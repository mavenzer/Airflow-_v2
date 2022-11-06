FROM python:3.8-slim-buster

LABEL maintainer="Soumen Sinha Mahapatra"

USER root

ENV PIP_INDEX_URL='https://pypi.python.org/simple/'

# Airflow
ARG AIRFLOW_VERSION=2.0.0
ARG AIRFLOW_USER_HOME_DIR=/home/airflow
ARG AIRFLOW_EXTRAS="crypto,postgres,jdbc,mysql,password,kubernetes"
ARG ADDITIONAL_AIRFLOW_EXTRAS=""
# Python dependancies for the local executor
ARG ADDITIONAL_PYTHON_DEPS="apache-airflow-upgrade-check apache-airflow-backport-providers-ftp apache-airflow-backport-providers-mysql apache-airflow-backport-providers-http numpy pandas  requests"
ARG AIRFLOW_HOME=/opt/airflow

# Needs to be changed as required
ARG AIRFLOW_UID="50000"
ARG AIRFLOW_GID="50000"

ENV AIRFLOW_HOME=${AIRFLOW_HOME}
ENV AIRFLOW_USER_HOME_DIR=${AIRFLOW_USER_HOME_DIR}
ENV PYTHONPATH="${PYTHONPATH}:${AIRFLOW_HOME}"

RUN groupadd --gid "${AIRFLOW_GID}" "airflow" && \
    useradd "airflow" --uid "${AIRFLOW_UID}" \
    --gid "${AIRFLOW_GID}" \
    --home "${AIRFLOW_USER_HOME_DIR}"
RUN pip install --upgrade setuptools

RUN pip install -U pip setuptools wheel \
    && pip install pytz \
    && pip install pyOpenSSL \
    && pip install ndg-httpsclient \
    && pip install pyasn1 \
    && pip install apache-airflow[crypto,celery,postgres,jdbc,mysql${AIRFLOW_DEPS:+,}${AIRFLOW_DEPS}]==${AIRFLOW_VERSION} \
    && if [ -n "${ADDITIONAL_PYTHON_DEPS}" ]; then pip install ${ADDITIONAL_PYTHON_DEPS}; fi

RUN mkdir -pv "${AIRFLOW_HOME}"; \
    mkdir -pv "${AIRFLOW_HOME}/dags"; \
    mkdir -pv "${AIRFLOW_HOME}/logs"; \
    mkdir -pv "${AIRFLOW_HOME}/data"; \
    chown -R "airflow:root" "${AIRFLOW_USER_HOME_DIR}" "${AIRFLOW_HOME}"; \
    find "${AIRFLOW_HOME}" -executable -print0 | xargs --null chmod g+x && \
    find "${AIRFLOW_HOME}" -print0 | xargs --null chmod g+rw

COPY scripts/entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh
COPY config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg
COPY config/webserver_config.py ${AIRFLOW_HOME}/webserver_config.py

COPY tini/tini /tini
RUN chmod +x /tini

RUN chmod g=u /etc/passwd


ENV PATH="${AIRFLOW_USER_HOME_DIR}/.local/bin:${PATH}"
ENV GUNICORN_CMD_ARGS="--worker-tmp-dir /dev/shm"


WORKDIR ${AIRFLOW_HOME}

EXPOSE 8080

USER ${AIRFLOW_UID}
ENTRYPOINT ["/tini", "--", "/entrypoint.sh"]
CMD ["webserver"]

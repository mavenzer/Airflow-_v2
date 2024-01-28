# Airflow-_v2

# Testing Airflow with HPA

# Testing PDP in Airflow


Images : 
postgresql:
  image:
    registry: docker.io
    repository: your-postgres-image
    tag: your-postgres-tag
    ...

redis:
  image:
    registry: docker.io
    repository: your-redis-image
    tag: your-redis-tag
    ...

airflow:
  worker:
    image:
      registry: docker.io
      repository: your-airflow-worker-image
      tag: your-airflow-worker-tag
      ...
  scheduler:
    image:
      registry: docker.io
      repository: your-airflow-scheduler-image
      tag: your-airflow-scheduler-tag
      ...
  web:
    image:
      registry: docker.io
      repository: your-airflow-webserver-image
      tag: your-airflow-webserver-tag
      ...

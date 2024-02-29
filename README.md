# Airflow-_v2

# Testing Airflow with HPA

# Testing PDP in Airflow

#### Helm Deployment
helm install your-release-name bitnami/airflow \
  --set postgresql.image.repository=your-postgres-image \
  --set postgresql.image.tag=your-postgres-tag \
  --set redis.image.repository=your-redis-image \
  --set redis.image.tag=your-redis-tag \
  --set airflow.worker.image.repository=your-airflow-worker-image \
  --set airflow.worker.image.tag=your-airflow-worker-tag \
  --set airflow.scheduler.image.repository=your-airflow-scheduler-image \
  --set airflow.scheduler.image.tag=your-airflow-scheduler-tag \
  --set airflow.web.image.repository=your-airflow-webserver-image \
  --set airflow.web.image.tag=your-airflow-webserver-tag


#### Deploying Airflow with Bitnami Helm charts 
```
helm install my-airflow bitnami/airflow \
  --set web.securityContext.runAsUser=1001 \
  --set web.securityContext.runAsGroup=1001 \
  --set web.securityContext.fsGroup=1001 \
  --set scheduler.securityContext.runAsUser=1001 \
  --set scheduler.securityContext.runAsGroup=1001 \
  --set scheduler.securityContext.fsGroup=1001 \
  --set worker.securityContext.runAsUser=1001 \
  --set worker.securityContext.runAsGroup=1001 \
  --set worker.securityContext.fsGroup=1001
```

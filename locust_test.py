from locust import HttpUser, task

class AirflowUser(HttpUser):
    @task
    def load_homepage(self):
        # Simulate loading the Airflow home page
        self.client.get("/")

    @task
    def list_dags(self):
        # Simulate listing all DAGs using Airflow's REST API (Airflow 2.x)
        headers = {'Authorization': 'Bearer YOUR_API_TOKEN'}
        self.client.get("/api/v1/dags", headers=headers)

    @task
    def trigger_dag(self):
        # Simulate triggering a specific DAG run using Airflow's REST API
        # Replace 'example_dag' with the DAG ID you want to test
        headers = {'Authorization': 'Bearer YOUR_API_TOKEN', 'Content-Type': 'application/json'}
        self.client.post("/api/v1/dags/example_dag/dagRuns", json={"conf": {}}, headers=headers)

# Testing DAG

from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime

def print_task_number(task_number: int):
    print(f"Executing task number {task_number}")

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2023, 8, 8),
    'retries': 1,
}

with DAG(
    'parallel_execution_dag',
    default_args=default_args,
    description='A simple DAG to test parallel execution',
    schedule_interval='@once',
    catchup=False,
    tags=['example'],
) as dag:

    # Create 10 tasks that will run in parallel
    for i in range(10):
        task = PythonOperator(
            task_id=f'task_number_{i}',
            python_callable=print_task_number,
            op_args=[i],
        )

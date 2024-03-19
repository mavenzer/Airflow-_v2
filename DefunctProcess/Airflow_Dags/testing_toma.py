import os
from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash_operator import BashOperator

# Global level code
os.system('hostname')
host = os.popen('hostname').read().encode('utf-8').decode('utf-8')
print(f"Hostname: {host}")

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email': ['your_email@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    'simple_bash_dag',
    default_args=default_args,
    description='A simple DAG to run bash commands',
    schedule_interval=timedelta(days=1),
    start_date=datetime(2023, 1, 1),
    catchup=False,
) as dag:

    # Task to run a bash command
    run_bash_command = BashOperator(
        task_id='run_bash_command',
        bash_command='echo "Running on host: $(hostname)"',
    )

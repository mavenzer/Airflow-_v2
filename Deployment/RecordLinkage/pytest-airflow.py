import pytest
from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator

# define a helper function that creates a DAG object with a single dummy operator
def create_dag():
    dag = DAG(
        'test_dag',
        start_date=datetime(2020, 1, 1),
        schedule_interval=None
    )

    DummyOperator(
        task_id='dummy_task',
        dag=dag
    )

    return dag

# define a test that checks if the DAG object is created successfully
def test_create_dag():
    dag = create_dag()
    assert dag is not None

# define a test that checks if the DAG object has a single dummy operator
def test_dag_has_operator():
    dag = create_dag()
    tasks = list(dag.tasks)
    assert len(tasks) == 1
    assert isinstance(tasks[0], DummyOperator)
You can then run your tests using the pytest command.

Copy code
$ pytest

from datetime import datetime

from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook


SNOWFLAKE_CONN_ID = "snowflake_project"


def validate_raw_data():
    hook = SnowflakeHook(snowflake_conn_id=SNOWFLAKE_CONN_ID)

    result = hook.get_first(
        """
        SELECT COUNT(*)
        FROM FIVETRAN.S3_ECOMMERCE_DATA.CUSTOMERS
        """
    )

    row_count = result[0]

    if row_count == 0:
        raise ValueError("RAW CUSTOMERS table is empty")

    print(f"RAW CUSTOMERS row count: {row_count}")


def run_dbt():
    import subprocess

    result = subprocess.run(
        [
            "/home/airflow/.local/bin/dbt",
            "run",
            "--project-dir",
            "/opt/airflow/dbt/ecommerce_dbt",
            "--profiles-dir",
            "/home/airflow/.dbt",
        ],
        capture_output=True,
        text=True,
    )

    print(result.stdout)
    print(result.stderr)

    if result.returncode != 0:
        raise RuntimeError("dbt run failed")


def test_dbt():
    import subprocess

    result = subprocess.run(
        [
            "/home/airflow/.local/bin/dbt",
            "test",
            "--project-dir",
            "/opt/airflow/dbt/ecommerce_dbt",
            "--profiles-dir",
            "/home/airflow/.dbt",
        ],
        capture_output=True,
        text=True,
    )

    print(result.stdout)
    print(result.stderr)

    if result.returncode != 0:
        raise RuntimeError("dbt test failed")


with DAG(
    dag_id="ecommerce_end_to_end_pipeline",
    start_date=datetime(2026, 8, 31),
    schedule=None,
    catchup=False,
    tags=["ecommerce", "snowflake", "dbt", "powerbi"],
) as dag:

    validate_raw = PythonOperator(
        task_id="validate_raw_data",
        python_callable=validate_raw_data,
    )

    dbt_run = PythonOperator(
        task_id="dbt_run",
        python_callable=run_dbt,
    )

    dbt_test = PythonOperator(
        task_id="dbt_test",
        python_callable=test_dbt,
    )

    validate_raw >> dbt_run >> dbt_test

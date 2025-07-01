locals {
  common_env = {
    AIRFLOW__CORE__EXECUTOR           = "LocalExecutor"
    AIRFLOW__CORE__SQL_ALCHEMY_CONN   = "sqlite:////opt/airflow/airflow.db"
    AIRFLOW_HOME                      = "/opt/airflow"
    AIRFLOW__LOGGING__LOG_LEVEL       = "DEBUG"
    AIRFLOW__CORE__LOAD_EXAMPLES      = "True"
    AIRFLOW__API__AUTH_BACKENDS       = "airflow.api.auth.backend.basic_auth"
    AIRFLOW__CORE__DAGS_FOLDER        = "/opt/airflow/dags"
    AIRFLOW__CORE__DEFAULT_TIMEZONE   = "utc"
  }
}

terraform {
  source = "../../../../modules/airflow"
}

inputs = {
  container_name = "local-data-stack-airflow-dag-processor"
  command        = ["dag-processor"]
  common_env       = merge(local.common_env, {})
}
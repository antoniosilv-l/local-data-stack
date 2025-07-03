locals {
  airflow_env = {
    AIRFLOW__DATABASE__SQL_ALCHEMY_CONN = "postgresql+psycopg2://airflow:airflow123@local-data-stack-postgres:5432/airflow"
    
    # Configurações do Core
    AIRFLOW__CORE__EXECUTOR           = "LocalExecutor"
    AIRFLOW_HOME                      = "/opt/airflow"
    AIRFLOW__LOGGING__LOG_LEVEL       = "DEBUG"
    AIRFLOW__CORE__LOAD_EXAMPLES      = "True"
    AIRFLOW__CORE__DAGS_FOLDER        = "/opt/airflow/dags"
    AIRFLOW__CORE__DEFAULT_TIMEZONE   = "utc"
    
    # Configurações da API
    AIRFLOW__API__AUTH_BACKENDS       = "airflow.api.auth.backend.basic_auth"
    AIRFLOW__WEBSERVER__RBAC          = "True"
    
    # Configurações de Conectividade
    AIRFLOW__CORE__PARALLELISM        = "32"
    AIRFLOW__CORE__MAX_ACTIVE_RUNS_PER_DAG = "16"
    
    # Configurações do Webserver
    AIRFLOW__WEBSERVER__EXPOSE_CONFIG = "True"
    AIRFLOW__WEBSERVER__WORKERS       = "4"
  }
} 


terraform {
  source = "../../../../modules/airflow"
}

inputs = {
  container_name = "local-data-stack-airflow-triggerer"
  airflow_image  = "local:airflow-latest-python3.11"
  command        = ["triggerer"]
  common_env     = local.airflow_env
  volumes = [{
    container_path = "/opt/airflow"
    host_path      = "/home/asilva/_git/projects/local-data-stack/stack/airflow"
  }]
}
terraform {
  source = "../../../modules/postgres"
}

inputs = {
  container_name = "local-data-stack-postgres"
  postgres_image = "postgres:15-alpine"
  
  common_env = {
    POSTGRES_DB       = "airflow"
    POSTGRES_USER     = "airflow"
    POSTGRES_PASSWORD = "airflow123"
  }

  ports = [{
    internal = 5432
    external = 5432
  }]

  volumes = [{
    container_path = "/var/lib/postgresql/data"
    host_path      = "/home/asilva/_git/projects/local-data-stack/stack/postgres"
  }]
} 
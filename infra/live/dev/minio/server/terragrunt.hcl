locals {
  minio_env = {
    MINIO_ROOT_USER      = "root"
    MINIO_ROOT_PASSWORD  = "root1234"
    MINIO_SERVER_URL     = "http://localhost:9000"
    MINIO_BROWSER_URL    = "http://localhost:9001"
  }
}

terraform {
  source = "../../../../modules/container"
}

inputs = {
    # Configurações do container
    container_name = "local-data-stack-minio-server"
    container_image = "minio/minio:latest"
    command = ["server", "/data", "--console-address", ":9001", "--address", ":9000"]
    common_env = local.minio_env
    restart_policy = "no"
  
    # Configurações de rede
    create_network = false
    networks = [{
        name = "local-data-stack-network"
        aliases = ["minio-server"]
    }]
  
    # Recursos
    cpu_shares = 1024
    memory_limit = 2048
  
    # Healthcheck
    healthcheck = {
        test         = ["CMD", "curl", "--fail", "http://localhost:9000/minio/health/live"]
        interval     = "30s"
        timeout      = "10s"
        start_period = "30s"
        retries      = 3
    }
  
    # Mapeamento de portas
    ports = [
        {
            internal = 9000
            external = 9000
            protocol = "tcp",
            ip       = "0.0.0.0"
        },
        {
            internal = 9001
            external = 9001
            protocol = "tcp",
            ip       = "0.0.0.0"
        }
    ]
  
    # Volumes
    volumes = [
        {
            container_path = "/opt/minio/data"
            host_path      = "/home/asilva/_git/local-data-stack/stack/minio/data"
            read_only      = false
        }
    ]
  
    # Labels
    labels = {
        "com.docker.stack.namespace" = "local-data-stack"
        "com.docker.stack.service"   = "minio-server"
        "environment"                = "development"
    }
    
    # Logging
    log_driver = "json-file"
    log_opts = {
        "max-size" = "10m"
        "max-file" = "3"
    }
}
locals {
    path = path_relative_to_include()
    path_dash = replace(local.path, "/", "-")

    dremio_env = {
        DREMIO_S3_ACCESS_KEY              = "minioadmin"
        DREMIO_S3_SECRET_KEY              = "minioadmin"
        DREMIO_S3_ENDPOINT                = "http://minio-server:9000"
        DREMIO_S3_REGION                  = "us-east-1"
        DREMIO_S3_BUCKET                  = "local-data-stack-dremio"
        DREMIO_STORAGE_PLUGIN             = "s3"
        DREMIO_WEB_PORT                   = "9047"
        DREMIO_COORDINATOR_PORT           = "31010"
        DREMIO_EXECUTOR_PORT              = "31011"
        DREMIO_ALLOW_CUSTOM_SCRIPTS       = "true"
        DREMIO_DEBUG                      = "false"
    }
}

terraform {
    source = "../../../modules/container"
}

inputs = {
    # Configurações do container
    container_name  = "local-data-stack-${local.path_dash}"
    container_image = "dremio/dremio-oss:latest"
    common_env      = local.dremio_env
    restart_policy  = "no"

    # Configurações de rede
    create_network  = false
    networks = [{
        name = "local-data-stack-network"
        aliases = ["dremio"]
    }]

    # Recursos
    cpu_shares      = 1024
    memory_limit    = 2048

    # Healthcheck
    healthcheck = {
        test        = ["CMD", "curl", "--fail", "http://localhost:9047/apiv2/server_status"]
        interval    = "30s"
        timeout     = "10s"
        start_period = "30s"
        retries     = 3
    }

    # Mapeamento de portas
    ports = [
        {
            internal = 9047
            external = 9047
            protocol = "tcp",
            ip = "0.0.0.0"
        },
        {
            internal = 31010
            external = 31010
            protocol = "tcp",
            ip = "0.0.0.0"
        },
        {
            internal = 32010
            external = 32010
            protocol = "tcp",
            ip = "0.0.0.0"
        },
        {
            internal = 45678
            external = 45678
            protocol = "tcp",
            ip = "0.0.0.0"
        }
    ]

    # Volumes
    volumes = [
        {
            container_path = "/opt/dremio/data/dist"
            host_path      = "/home/asilva/_git/local-data-stack/stack/dremio/data"
            read_only      = false
        }
    ]
  
    # Labels
    labels = {
        "com.docker.stack.namespace" = "local-data-stack"
        "com.docker.stack.service"   = "dremio"
        "environment"                = "development"
    }
    
    # Logging
    log_driver = "json-file"
    log_opts = {
        "max-size" = "10m"
        "max-file" = "3"
    }
}
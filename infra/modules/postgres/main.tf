resource "docker_image" "postgres" {
  name = var.postgres_image
}

resource "docker_container" "this" {
  name  = var.container_name
  image = docker_image.postgres.name
  command = var.command

  env = [for k, v in var.common_env : "${k}=${v}"]

  networks_advanced {
    name = "local-data-stack-network"
  }

  dynamic "ports" {
    for_each = var.ports
    content {
      internal = ports.value.internal
      external = ports.value.external
    }
  }

  dynamic "volumes" {
    for_each = var.volumes
    content {
      container_path = volumes.value.container_path
      host_path      = volumes.value.host_path
    }
  }
}
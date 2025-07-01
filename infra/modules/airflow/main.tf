resource "docker_image" "airflow" {
  name = var.airflow_image
}

resource "docker_container" "this" {
  name  = var.container_name
  image = docker_image.airflow.image_id
  command = var.command

  env = [for k, v in var.common_env : "${k}=${v}"]

  dynamic "ports" {
    for_each = var.ports
    content {
      internal = ports.value.internal
      external = ports.value.external
    }
  }
}
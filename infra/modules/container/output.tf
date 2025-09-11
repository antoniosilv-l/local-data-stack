output "container_id" {
  description = "ID do container"
  value       = docker_container.this.id
}

output "container_name" {
  description = "Nome do container"
  value       = docker_container.this.name
}

output "network_id" {
  description = "ID da rede Docker criada"
  value       = try(docker_network.network[0].id, null)
}

output "network_name" {
  description = "Nome da rede Docker criada"
  value       = try(docker_network.network[0].name, null)
}

output "image_id" {
  description = "ID da imagem Docker"
  value       = docker_image.container.id
}

output "container_ip" {
  description = "IP do container na rede"
  value       = try(docker_container.this.network_data[0].ip_address, null)
}

output "container_ports" {
  description = "Mapeamento de portas do container"
  value = [
    for port in docker_container.this.ports : {
      internal = port.internal
      external = port.external
      protocol = port.protocol
      ip       = port.ip
    }
  ]
}

output "container_mounts" {
  description = "Mapeamento de volumes do container"
  value = [
    for volume in docker_container.this.volumes : {
      container_path = volume.container_path
      host_path      = volume.host_path
      read_only      = volume.read_only
    }
  ]
}
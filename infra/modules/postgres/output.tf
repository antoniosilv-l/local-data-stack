output "container_id" {
  description = "ID do container PostgreSQL"
  value       = docker_container.this.id
}

output "container_name" {
  description = "Nome do container PostgreSQL"
  value       = docker_container.this.name
}



output "ports" {
  description = "Portas expostas do PostgreSQL"
  value       = docker_container.this.ports
}

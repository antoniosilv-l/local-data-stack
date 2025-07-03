variable "postgres_image" {
    type = string
    default = "postgres:16.9-alpine3.22" 
}

variable "container_name" {
  type = string
}

variable "command" {
  type = list(string)
  default = null
}

variable "common_env" {
  type = map(string)
  default = {}
}

variable "ports" {
  type = list(object({
    internal = number
    external = number
  }))
  default = []
}

variable "volumes" {
  type = list(object({
    container_path = string
    host_path      = string
  }))
  default = []
}
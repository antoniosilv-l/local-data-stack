variable "airflow_image" {
    type = string
    default = "apache/airflow:slim-latest-python3.11" 
}

variable "container_name" {
  type = string
}

variable "command" {
  type = list(string)
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
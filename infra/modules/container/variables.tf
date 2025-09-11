# Configuracões basicas do container
variable "container_image" {
  description = "The Docker image to use for the container"
  type        = string
}

variable "container_name" {
  description = "The name of the container"
  type        = string
}

variable "hostname" {
  description = "Container hostname"
  type        = string
  default     = null
}

variable "domainname" {
  description = "Container domain name"
  type        = string
  default     = null
}

variable "command" {
  description = "The command to run in the container"
  type        = list(string)
  default     = null
}

variable "entrypoint" {
  description = "The entrypoint for the container"
  type        = list(string)
  default     = null
}

variable "working_dir" {
  description = "The working directory for commands to run in"
  type        = string
  default     = null
}

variable "container_user" {
  description = "User to run commands as in the container"
  type        = string
  default     = ""
}

variable "restart_policy" {
  description = "Restart policy for the container"
  type        = string
  default     = "unless-stopped"
}

## Configuracoes de logs dos containers
variable "log_driver" {
  description = "The logging driver to use"
  type        = string
  default     = "json-file"
}

variable "log_opts" {
  description = "The logging driver options"
  type        = map(string)
  default     = {}
}

## Limites dos recursos
variable "cpu_shares" {
  description = "CPU shares (relative weight)"
  type        = number
  default     = null
}

variable "cpu_set" {
  description = "CPUs in which to allow execution"
  type        = string
  default     = null
}

variable "memory_limit" {
  description = "Memory limit in bytes"
  type        = number
  default     = null
}

variable "memory_swap" {
  description = "Total memory limit (memory + swap)"
  type        = number
  default     = null
}

## Verificao da saude dos containers
variable "healthcheck" {
  description = "Healthcheck configuration for the container"
  type = object({
    test         = list(string)
    interval     = string
    timeout      = string
    start_period = string
    retries      = number
  })
  default = null
}

## Variaveis de ambiente
variable "common_env" {
  description = "Common environment variables"
  type        = map(string)
  default     = {}
}

variable "additional_env" {
  description = "Additional environment variables"
  type        = list(string)
  default     = []
}

## Mapeamento de portas
variable "ports" {
  description = "Port mappings"
  type = list(object({
    internal = number
    external = number
    protocol = optional(string, "tcp")
    ip       = optional(string)
  }))
  default = []
}

## Montagens de volumes
variable "volumes" {
  description = "Volume mappings"
  type = list(object({
    container_path = string
    host_path      = string
    read_only      = optional(bool, false)
    volume_name    = optional(string)
  }))
  default = []
}

## Configuracoes de segredos/senhas
variable "secret_mounts" {
  description = "Secret mount configurations"
  type = list(object({
    target = string
    source = string
  }))
  default = []
}

## Tags/Labels
variable "labels" {
  description = "Container labels"
  type        = map(string)
  default     = {}
}

## Configurações de dispositivos
variable "devices" {
  description = "Device mappings"
  type = list(object({
    host_path      = string
    container_path = string
    permissions    = string
  }))
  default = []
}

## Configurações avançadas
variable "runtime" {
  description = "Runtime to use for the container"
  type        = string
  default     = null
}

variable "init_process" {
  description = "Run an init inside the container"
  type        = bool
  default     = false
}

variable "privileged" {
  description = "Give extended privileges to this container"
  type        = bool
  default     = false
}

variable "read_only" {
  description = "Mount the container's root filesystem as read only"
  type        = bool
  default     = false
}

variable "network_mode" {
  description = "Network mode to use for the container"
  type        = string
  default     = "default"
}

variable "ipc_mode" {
  description = "IPC sharing mode for the container"
  type        = string
  default     = null
}

variable "pid_mode" {
  description = "PID namespace mode for the container"
  type        = string
  default     = null
}

variable "userns_mode" {
  description = "User namespace mode for the container"
  type        = string
  default     = null
}

## Remocao automatica do container ao sair
variable "remove_on_exit" {
  description = "Remove container on exit"
  type        = bool
  default     = false
}

# Recursos de rede
variable "create_network" {
  description = "Whether to create a Docker network"
  type        = bool
  default     = false
}

variable "network_name" {
  description = "The name of the Docker network"
  type        = string
  default     = "local-data-stack-network"
}

variable "network_driver" {
  description = "The driver for the Docker network"
  type        = string
  default     = "bridge"
}

variable "network_subnet" {
  description = "The subnet for the Docker network"
  type        = string
  default     = "172.28.0.0/16"
}

variable "network_gateway" {
  description = "The gateway for the Docker network"
  type        = string
  default     = "172.28.0.1"
}

# Recursos de Imagem
variable "keep_image_locally" {
  description = "If true, then the Docker image won't be deleted on destroy"
  type        = bool
  default     = true
}

variable "image_pull_triggers" {
  description = "List of triggers that will cause the image to be pulled again"
  type        = list(string)
  default     = []
}

variable "force_remove_image" {
  description = "If true, then the image will be removed forcefully"
  type        = bool
  default     = false
}

variable "build_config" {
  description = "Configuration for building the Docker image"
  type = object({
    context     = string
    dockerfile  = string
    build_args  = map(string)
    target      = string
  })
  default = null
}

# Recursos de segredos/senhas
variable "secrets" {
  description = "Map of secrets to create"
  type        = map(string)
  default     = {}
}

# Recursos de configuracoes
variable "configs" {
  description = "Map of configs to create"
  type        = map(string)
  default     = {}
}


























variable "networks" {
  description = "Networks to attach to the container"
  type = list(object({
    name         = string
    aliases      = optional(list(string))
    ipv4_address = optional(string)
    ipv6_address = optional(string)
  }))
  default = []
}

resource "docker_container" "this" {
  # Configuracões basicas do container
  name         = var.container_name
  image        = var.container_image
  hostname     = var.hostname
  domainname   = var.domainname
  command      = var.command
  entrypoint   = var.entrypoint
  working_dir  = var.working_dir
  user         = var.container_user
  restart      = var.restart_policy
  
  ## Configuracoes de logs dos containers
  log_driver = var.log_driver
  log_opts   = var.log_opts
  logs       = true

  ## Limites dos recursos
  cpu_shares    = var.cpu_shares
  cpu_set       = var.cpu_set
  memory        = var.memory_limit
  memory_swap   = var.memory_swap
  
  ## Verificao da saude dos containers
  dynamic "healthcheck" {
    for_each = var.healthcheck != null ? [var.healthcheck] : []
    content {
      test         = healthcheck.value.test
      interval     = healthcheck.value.interval
      timeout      = healthcheck.value.timeout
      start_period = healthcheck.value.start_period
      retries      = healthcheck.value.retries
    }
  }

  ## Variaveis de ambiente
  env = concat(
    [for k, v in var.common_env : "${k}=${v}"],
    var.additional_env
  )

  ## Network configuration
  dynamic "networks_advanced" {
    for_each = var.networks
    content {
      name         = networks_advanced.value.name
      aliases      = networks_advanced.value.aliases
      ipv4_address = networks_advanced.value.ipv4_address
      ipv6_address = networks_advanced.value.ipv6_address
    }
  }

  ## Mapeamento de portas
  dynamic "ports" {
    for_each = var.ports
    content {
      internal = ports.value.internal
      external = ports.value.external
      protocol = ports.value.protocol
      ip       = ports.value.ip
    }
  }

  ## Montagens de volumes
  dynamic "volumes" {
    for_each = var.volumes
    content {
      container_path = volumes.value.container_path
      host_path      = volumes.value.host_path
      read_only      = volumes.value.read_only
      volume_name    = volumes.value.volume_name
    }
  }

  ## Configuracoes de segredos/senhas
  dynamic "mounts" {
    for_each = var.secret_mounts
    content {
      target    = mounts.value.target
      source    = mounts.value.source
      type      = "secret"
      read_only = true
    }
  }

  ## Tags/Labels
  dynamic "labels" {
    for_each = var.labels
    content {
      label = labels.key
      value = labels.value
    }
  }

  ## Configurações de dispositivos
  dynamic "devices" {
    for_each = var.devices
    content {
      host_path      = devices.value.host_path
      container_path = devices.value.container_path
      permissions    = devices.value.permissions
    }
  }

  ## Configurações avançadas
  runtime      = var.runtime
  init         = var.init_process
  privileged   = var.privileged
  read_only    = var.read_only
  network_mode = var.network_mode
  ipc_mode     = var.ipc_mode
  pid_mode     = var.pid_mode
  userns_mode  = var.userns_mode

  ## Remocao automatica do container ao sair
  rm = var.remove_on_exit

  depends_on = [
    docker_network.network,
    docker_secret.secrets,
    docker_config.configs
  ]
}

# Recursos de rede
resource "docker_network" "network" {
  count = var.create_network ? 1 : 0
  name  = var.network_name
  driver = var.network_driver
  
  ipam_config {
    subnet  = var.network_subnet
    gateway = var.network_gateway
  }
}

# Recursos de Imagem
resource "docker_image" "container" {
  name          = var.container_image
  keep_locally  = var.keep_image_locally
  pull_triggers = var.image_pull_triggers
  force_remove  = var.force_remove_image

  dynamic "build" {
    for_each = var.build_config != null ? [var.build_config] : []
    content {
      context    = build.value.context
      dockerfile = build.value.dockerfile
      build_args = build.value.build_args
      target     = build.value.target
    }
  }
}

# Recursos de segredos/senhas
resource "docker_secret" "secrets" {
  for_each = var.secrets
  
  name = each.key
  data = base64encode(each.value)
}

# Recursos de configuracoes
resource "docker_config" "configs" {
  for_each = var.configs
  
  name = each.key
  data = base64encode(each.value)
}


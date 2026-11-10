# Resource Group
variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))

  description = "Resource Groups configuration"
}

# Storage Account
variable "storage_accounts" {
  type = map(object({
    name             = string
    resource_groups  = string
    location         = string
    replication_type = string
    account_tier     = string
    tags             = map(string)
  }))
  description = "Storage Account configuration"

}

# Virtual Network
variable "vnets" {

  description = "Map of Azure Virtual Networks."

  type = map(object({
    name           = string
    location       = string
    resource_group = string
    address_space  = list(string)

    dns_servers = optional(list(string), [])

    tags = optional(map(string), {})
  }))
}

# Subnet
variable "subnet" {
  description = "Map of Azure subnets"

  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
    service_endpoints    = list(string)

  }))

}

# Key Vault

variable "key_vaults" {
  description = "Production Key Vault configurations"

  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    tenant_id                     = string
    sku_name                      = string
    enabled_for_disk_encryption   = bool
    soft_delete_retention_days    = number
    purge_protection_enabled      = bool
    public_network_access_enabled = bool
    rbac_authorization_enabled    = bool
    tags                          = map(string)
  }))
}

# Virtual Machine

variable "vms" {
  description = "Configuration for Azure Linux Virtual Machines"

  type = map(object({
    name                  = string
    location              = string
    resource_group        = string
    size                  = string
    subnet_name           = string
    vnet_name             = string
    subnet_resource_group = string
    key_vault_key         = string
    username_secret_name  = string
    password_secret_name  = string
    os_disk_type          = string
    tags                  = map(string)
  }))
}


# Public IP

variable "public_ips" {
  description = "Production Azure Public IP configurations"

  type = map(object({
    name                    = string
    location                = string
    resource_group_name     = string
    allocation_method       = string
    sku                     = string
    sku_tier                = string
    ip_version              = string
    zones                   = optional(list(string), null)
    domain_name_label       = optional(string, null)
    idle_timeout_in_minutes = optional(number, 10)
    tags                    = map(string)
  }))
}

# Application Gateway

variable "application_gateways" {
  description = "Production Azure Application Gateway configurations"

  type = map(object({

    name                = string
    location            = string
    resource_group_name = string

    subnet_id            = string
    public_ip_address_id = string

    sku_name = string
    sku_tier = string

    min_capacity = number
    max_capacity = number

    zones        = optional(list(string), null)
    enable_http2 = optional(bool, true)

    frontend_port = number

    backend_address_pool_name = string
    backend_addresses         = list(string)

    backend_http_settings_name = string
    backend_port               = number
    backend_protocol           = string
    request_timeout            = number
    cookie_based_affinity      = string
    backend_path               = optional(string, null)

    probe_name     = string
    probe_path     = string
    probe_protocol = string

    pick_host_name_from_backend_http_settings = optional(bool, true)

    probe_interval            = number
    probe_timeout             = number
    probe_unhealthy_threshold = number

    frontend_ip_configuration_name = string
    frontend_port_name             = string

    http_listener_name = string
    listener_protocol  = string

    request_routing_rule_name = string
    request_routing_priority  = number
    request_routing_rule_type = string

    tags = map(string)

  }))
}


# Bation Host

variable "bastion_hosts" {
  description = "Production Azure Bastion Host configurations"

  type = map(object({
    name                   = string
    location               = string
    resource_group_name    = string
    subnet_id              = string
    public_ip_address_id   = string
    sku                    = optional(string, "Standard")
    scale_units            = optional(number, 2)
    copy_paste_enabled     = optional(bool, true)
    file_copy_enabled      = optional(bool, true)
    ip_connect_enabled     = optional(bool, true)
    shareable_link_enabled = optional(bool, false)
    tunneling_enabled      = optional(bool, true)
    tags                   = map(string)
  }))
}

# LoadBalancer

variable "load_balancers" {
  description = "Production Azure Load Balancers"

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    sku                 = optional(string, "Standard")
    sku_tier            = optional(string, "Regional")

    frontend_ip_configurations = map(object({
      name                          = string
      public_ip_address_id          = optional(string)
      subnet_id                     = optional(string)
      private_ip_address            = optional(string)
      private_ip_address_allocation = optional(string, "Dynamic")
      private_ip_address_version    = optional(string, "IPv4")
      zones                         = optional(list(string))
    }))

    tags = optional(map(string), {})
  }))
}

# NSG

variable "network_security_groups" {
  description = "Production Network Security Groups"

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    security_rules = map(object({
      name      = string
      priority  = number
      direction = string
      access    = string
      protocol  = string

      source_port_range      = optional(string, "*")
      destination_port_range = optional(string, "*")

      source_address_prefix   = optional(string)
      source_address_prefixes = optional(list(string))

      destination_address_prefix   = optional(string)
      destination_address_prefixes = optional(list(string))
    }))

    tags = optional(map(string), {})
  }))
}


# Private Endpoint

variable "private_endpoints" {
  description = "Production Azure Private Endpoints"

  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    subnet_id                     = string
    custom_network_interface_name = optional(string)

    private_service_connection = object({
      name                           = string
      private_connection_resource_id = string
      is_manual_connection           = optional(bool, false)
      subresource_names              = optional(list(string))
      request_message                = optional(string)
    })

    private_dns_zone_group = optional(object({
      name                 = optional(string, "default")
      private_dns_zone_ids = list(string)
    }))

    tags = optional(map(string), {})
  }))
}
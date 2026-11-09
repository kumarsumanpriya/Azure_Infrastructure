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
    name                = string
    location            = string
    resource_group_name = string
    allocation_method = string
    sku               = string
    sku_tier           = string
    ip_version = string
    zones = optional(list(string), null)
    domain_name_label = optional(string, null)
    idle_timeout_in_minutes = optional(number, 10)
    tags = map(string)
  }))
}

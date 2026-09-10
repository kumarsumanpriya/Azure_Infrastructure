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
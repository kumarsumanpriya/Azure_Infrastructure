variable "public_ips" {
  description = "Configuration for Azure Public IP Addresses"

  type = map(object({

    name                = string
    location            = string
    resource_group_name = string

    allocation_method = string
    sku               = string
    sku_tier          = string

    ip_version = string

    zones = optional(list(string), null)

    domain_name_label = optional(string, null)

    idle_timeout_in_minutes = optional(number, 10)

    tags = map(string)

  }))

  validation {
    condition = alltrue([
      for ip in var.public_ips :
      contains(["Static"], ip.allocation_method)
    ])

    error_message = "Only Static allocation method is supported."
  }

  validation {
    condition = alltrue([
      for ip in var.public_ips :
      contains(["Standard"], ip.sku)
    ])

    error_message = "Only Standard SKU is supported."
  }

  validation {
    condition = alltrue([
      for ip in var.public_ips :
      contains(["Regional", "Global"], ip.sku_tier)
    ])

    error_message = "SKU tier must be Regional or Global."
  }

  validation {
    condition = alltrue([
      for ip in var.public_ips :
      contains(["IPv4", "IPv6"], ip.ip_version)
    ])

    error_message = "IP version must be IPv4 or IPv6."
  }
}
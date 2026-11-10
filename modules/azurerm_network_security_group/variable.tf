variable "network_security_groups" {
  description = "Map of Azure Network Security Groups"

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

  validation {
    condition = alltrue([
      for nsg in values(var.network_security_groups) :
      alltrue([
        for rule in values(nsg.security_rules) :
        rule.priority >= 100 && rule.priority <= 4096
      ])
    ])

    error_message = "Security rule priority must be between 100 and 4096."
  }

  validation {
    condition = alltrue([
      for nsg in values(var.network_security_groups) :
      alltrue([
        for rule in values(nsg.security_rules) :
        contains(["Inbound", "Outbound"], rule.direction)
      ])
    ])

    error_message = "Direction must be Inbound or Outbound."
  }

  validation {
    condition = alltrue([
      for nsg in values(var.network_security_groups) :
      alltrue([
        for rule in values(nsg.security_rules) :
        contains(["Allow", "Deny"], rule.access)
      ])
    ])

    error_message = "Access must be Allow or Deny."
  }
}
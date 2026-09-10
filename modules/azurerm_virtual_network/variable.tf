variable "vnets" {

  description = "Map of Azure Virtual Networks."

  type = map(object({
    name           = string
    location       = string
    resource_group = string
    address_space  = list(string)

    dns_servers    = optional(list(string), [])

    tags           = optional(map(string), {})
  }))
}
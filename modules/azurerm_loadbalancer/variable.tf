variable "load_balancers" {
  description = "Map of Azure Load Balancers"

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

  validation {
    condition = alltrue([
      for lb in values(var.load_balancers) :
      contains(["Basic", "Standard"], lb.sku)
    ])
    error_message = "Load Balancer SKU must be Basic or Standard."
  }
}
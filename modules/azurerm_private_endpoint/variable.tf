variable "private_endpoints" {
  description = "Map of Azure Private Endpoints"

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
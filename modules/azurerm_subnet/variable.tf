variable "subnet" {
    description = "Map of Azure subnets"

    type = map(object({
      name = string
      resource_group_name = string
      virtual_network_name = string
      address_prefixes = list(string)
      service_endpoints = list(string)
    }))

    default = {}

}
  



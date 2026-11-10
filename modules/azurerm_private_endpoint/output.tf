output "private_endpoint_details" {
  description = "Details of Azure Private Endpoints"

  value = {
    for key, pe in azurerm_private_endpoint.PE : key => {
      id                  = pe.id
      name                = pe.name
      location            = pe.location
      resource_group_name = pe.resource_group_name
      subnet_id           = pe.subnet_id

      network_interface = pe.network_interface

      private_service_connection = [
        for connection in pe.private_service_connection : {
          name                 = connection.name
          private_ip_address   = connection.private_ip_address
          subresource_names    = connection.subresource_names
          is_manual_connection = connection.is_manual_connection
        }
      ]

      private_dns_zone_configs = pe.private_dns_zone_configs
    }
  }
}
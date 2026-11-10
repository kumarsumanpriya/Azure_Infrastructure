output "application_gateway_details" {
  description = "Details of Azure Application Gateways"

  value = {
    for key, gateway in azurerm_application_gateway.AG : key => {

      id                  = gateway.id
      name                = gateway.name
      resource_group_name = gateway.resource_group_name
      location            = gateway.location

      frontend_ip_configuration = gateway.frontend_ip_configuration

      backend_address_pool = gateway.backend_address_pool

    }
  }
}
output "load_balancer_details" {
  description = "Details of Azure Load Balancers"

  value = {
    for key, lb in azurerm_lb.LB : key => {
      id                  = lb.id
      name                = lb.name
      location            = lb.location
      resource_group_name = lb.resource_group_name
      sku                 = lb.sku

      frontend_ip_configurations = {
        for frontend in lb.frontend_ip_configuration :
        frontend.name => {
          id         = frontend.id
          name       = frontend.name
          private_ip = frontend.private_ip_address
        }
      }
    }
  }
}
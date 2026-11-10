output "bastion_host_details" {

  description = "Details of Azure Bastion Hosts"

  value = {
    for key, bastion in azurerm_bastion_host.BH : key => {

      id                  = bastion.id
      name                = bastion.name
      location            = bastion.location
      resource_group_name = bastion.resource_group_name
      sku                 = bastion.sku
    }
  }
}
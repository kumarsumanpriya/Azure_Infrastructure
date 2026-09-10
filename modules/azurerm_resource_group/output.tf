output "resource_groups" {
  value = {
    for key, rg in azurerm_resource_group.rgs : key => {
      id       = rg.id
      name     = rg.name
      location = rg.location
    }
  }
}
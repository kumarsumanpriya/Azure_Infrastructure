output "vnets" {
  description = "Virtual Network details including ID, name, and address spaces."

  value = {
    for key, vnet in azurerm_virtual_network.vnet : key => {
      id             = vnet.id
      name           = vnet.name
      location       = vnet.location
      resource_group = vnet.resource_group_name
      address_space  = vnet.address_space
      dns_servers    = vnet.dns_servers
      tags           = vnet.tags
    }
  }
}

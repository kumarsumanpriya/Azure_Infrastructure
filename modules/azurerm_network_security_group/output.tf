output "network_security_group_details" {
  description = "Details of Azure Network Security Groups"

  value = {
    for key, nsg in azurerm_network_security_group.NSG : key => {
      id                  = nsg.id
      name                = nsg.name
      location            = nsg.location
      resource_group_name = nsg.resource_group_name

      security_rules = [
        for rule in nsg.security_rule : {
          name      = rule.name
          priority  = rule.priority
          direction = rule.direction
          access    = rule.access
          protocol  = rule.protocol
        }
      ]
    }
  }
}
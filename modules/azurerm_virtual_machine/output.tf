output "virtual_machines" {
  description = "Virtual Machine details including ID, Name, Size, Location, and Resource Group"

  value = {
    for key, vm in azurerm_linux_virtual_machine.vms : key => {
      id                  = vm.id
      name                = vm.name
      size                = vm.size
      location            = vm.location
      resource_group_name = vm.resource_group_name
    }
  }
}

output "network_interfaces" {
  description = "Network Interface details including ID, Name, and Private IP Address"

  value = {
    for key, nic in azurerm_network_interface.nic : key => {
      id                 = nic.id
      name               = nic.name
      private_ip_address = nic.private_ip_address
    }
  }
}
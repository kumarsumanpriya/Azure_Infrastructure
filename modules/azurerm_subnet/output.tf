output "subnet" {
    description = "Subnet details including ID, Name, Prefixes"
    
    value = {
        for key, subnet in azurerm_subnet.subnet : key => {
            id = subnet.id
            name = subnet.name
            address_prefixes = subnet.address_prefixes
        }
    }
}


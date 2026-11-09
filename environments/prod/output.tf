# Resource Group
output "resource_groups" {
  value = module.resource_groups.resource_groups
}

# Storage Account
output "storage_accounts" {
  value = module.storage_accounts.storage_accounts
}

# Virtual Network
output "vnets" {
  value = module.vnets.vnets

}

# Subnet
output "subnet_details" {
  value = module.subnet.subnet

}

# Key Vault

output "key_vault_details" {
  value = module.key_vault.key_vaults
}

# Virtual Machine

output "vms" {
  description = "Virtual Machine details including ID, Name, Size, Location, and Resource Group"

  value = module.vms.virtual_machines
}

output "network_interfaces" {
  description = "Network Interface details including ID, Name, and Private IP Address"

  value = module.vms.network_interfaces
}

# Public IP

output "public_ip_details" {
  description = "Production Public IP details"
  value = module.public_ip.public_ip_details
}
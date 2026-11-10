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
  value       = module.public_ip.public_ip_details
}

# Application Gateway

output "application_gateway_details" {
  description = "Production Application Gateway details"
  value       = module.application_gateway.application_gateway_details

}

# Bation Host

output "bastion_host_details" {
  description = "Production Azure Bastion Host details"
  value       = module.azurerm_bastion.bastion_host_details

}

# LoadBalancer

output "load_balancer_details" {
  description = "Production Load Balancer details"
  value       = module.load_balancer.load_balancer_details
}

# NSG

output "network_security_group_details" {
  description = "Production Network Security Group details"
  value       = module.network_security_group.network_security_group_details
}

# Private Endpoint

output "private_endpoint_details" {
  description = "Production Private Endpoint details"
  value       = module.private_endpoint.private_endpoint_details
}
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
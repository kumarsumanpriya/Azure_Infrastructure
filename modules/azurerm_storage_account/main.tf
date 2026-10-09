resource "azurerm_storage_account" "sa" {
  
  for_each = var.storage_accounts

  name                     = each.value.name
  resource_group_name      = each.value.resource_groups
  location                 = each.value.location
  account_replication_type = each.value.replication_type
  account_tier             = each.value.account_tier
  tags                     = each.value.tags
}
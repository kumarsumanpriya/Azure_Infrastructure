module "resource_groups" {
  source          = "../../modules/azurerm_resource_group"
  resource_groups = var.resource_groups
}

module "storage_accounts" {
  depends_on       = [module.resource_groups]
  source           = "../../modules/azurerm_storage_account"
  storage_accounts = var.storage_accounts
}

module "vnets" {
  depends_on = [module.resource_groups]
  source     = "../../modules/azurerm_virtual_network"
  vnets      = var.vnets
}
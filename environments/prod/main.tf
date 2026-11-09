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

module "subnet" {
  depends_on = [module.vnets]
  source     = "../../modules/azurerm_subnet"
  subnet     = var.subnet
}


module "key_vault" {
  depends_on = [module.resource_groups]
  source     = "../../modules/azurerm_key_vault"
  key_vaults = var.key_vaults
}

module "vms" {
  depends_on = [module.subnet, module.key_vault]
  source     = "../../modules/azurerm_virtual_machine"
  vms        = var.vms
}

module "public_ip" {
  depends_on = [module.resource_groups]
  source = "../../modules/azurerm_public_ip"
  public_ips = var.public_ips

}
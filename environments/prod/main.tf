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
  source     = "../../modules/azurerm_public_ip"
  public_ips = var.public_ips

}

module "application_gateway" {
  depends_on           = [module.resource_groups, module.vnets, module.subnet, module.public_ip]
  source               = "../../modules/azurerm_application_gateway"
  application_gateways = var.application_gateways

}

module "azurerm_bastion" {
  depends_on    = [module.resource_groups, module.vnets, module.subnet, module.public_ip]
  source        = "../../modules/azurerm_bastion"
  bastion_hosts = var.bastion_hosts

}

module "load_balancer" {
  depends_on     = [module.resource_groups, module.public_ip]
  source         = "../../modules/azurerm_loadbalancer"
  load_balancers = var.load_balancers
}

module "network_security_group" {
  depends_on              = [module.resource_groups, module.public_ip]
  source                  = "../../modules/azurerm_network_security_group"
  network_security_groups = var.network_security_groups
}

module "private_endpoint" {
  depends_on    = [module.resource_groups, module.vnets, module.subnet, module.public_ip]
  source            = "../../modules/azurerm_private_endpoint"
  private_endpoints = var.private_endpoints
}
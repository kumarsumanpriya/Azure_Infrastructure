resource "azurerm_lb" "LB" {
  for_each = var.load_balancers

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  sku      = each.value.sku
  sku_tier = each.value.sku_tier

  dynamic "frontend_ip_configuration" {
    for_each = each.value.frontend_ip_configurations

    content {
      name                 = frontend_ip_configuration.value.name
      public_ip_address_id = frontend_ip_configuration.value.public_ip_address_id
      subnet_id            = frontend_ip_configuration.value.subnet_id
      private_ip_address   = frontend_ip_configuration.value.private_ip_address
      private_ip_address_allocation = (
        frontend_ip_configuration.value.private_ip_address != null
        ? frontend_ip_configuration.value.private_ip_address_allocation
        : null
      )
      private_ip_address_version = frontend_ip_configuration.value.private_ip_address_version
      zones                      = frontend_ip_configuration.value.zones
    }
  }

  tags = each.value.tags

  lifecycle {
    prevent_destroy = true
  }
}
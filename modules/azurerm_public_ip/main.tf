resource "azurerm_public_ip" "this" {
  for_each = var.public_ips

  name                    = each.value.name
  location                = each.value.location
  resource_group_name     = each.value.resource_group_name
  allocation_method       = each.value.allocation_method
  sku                     = each.value.sku
  sku_tier                = each.value.sku_tier
  ip_version              = each.value.ip_version
  zones                   = each.value.zones
  domain_name_label       = each.value.domain_name_label
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
  tags                    = each.value.tags

  lifecycle {
    prevent_destroy = true
  }
}
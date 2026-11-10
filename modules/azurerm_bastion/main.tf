resource "azurerm_bastion_host" "BH" {

  for_each = var.bastion_hosts

  name                   = each.value.name
  location               = each.value.location
  resource_group_name    = each.value.resource_group_name
  sku                    = each.value.sku
  scale_units            = each.value.sku == "Basic" ? null : each.value.scale_units
  copy_paste_enabled     = each.value.copy_paste_enabled
  file_copy_enabled      = each.value.file_copy_enabled
  ip_connect_enabled     = each.value.ip_connect_enabled
  shareable_link_enabled = each.value.shareable_link_enabled
  tunneling_enabled      = each.value.tunneling_enabled

  ip_configuration {
    name                 = "${each.key}-ip-config"
    subnet_id            = each.value.subnet_id
    public_ip_address_id = each.value.public_ip_address_id
  }

  tags = each.value.tags

  lifecycle {
    prevent_destroy = true
  }
}
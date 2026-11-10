resource "azurerm_private_endpoint" "PE" {
  for_each = var.private_endpoints

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = each.value.subnet_id

  custom_network_interface_name = each.value.custom_network_interface_name

  private_service_connection {
    name                           = each.value.private_service_connection.name
    private_connection_resource_id = each.value.private_service_connection.private_connection_resource_id

    is_manual_connection = each.value.private_service_connection.is_manual_connection

    subresource_names = each.value.private_service_connection.subresource_names

    request_message = each.value.private_service_connection.request_message
  }

  dynamic "private_dns_zone_group" {
    for_each = each.value.private_dns_zone_group != null ? [each.value.private_dns_zone_group] : []

    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = private_dns_zone_group.value.private_dns_zone_ids
    }
  }

  tags = each.value.tags

  lifecycle {
    prevent_destroy = true
  }
}
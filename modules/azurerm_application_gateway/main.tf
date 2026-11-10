resource "azurerm_application_gateway" "AG" {

  for_each = var.application_gateways

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  zones         = each.value.zones
  http2_enabled = each.value.enable_http2

  sku {
    name = each.value.sku_name
    tier = each.value.sku_tier
  }

  autoscale_configuration {
    min_capacity = each.value.min_capacity
    max_capacity = each.value.max_capacity
  }

  gateway_ip_configuration {
    name      = "${each.key}-gateway-ip-config"
    subnet_id = each.value.subnet_id
  }

  frontend_port {
    name = each.value.frontend_port_name
    port = each.value.frontend_port
  }

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_configuration_name
    public_ip_address_id = each.value.public_ip_address_id
  }

  backend_address_pool {
    name         = each.value.backend_address_pool_name
    ip_addresses = each.value.backend_addresses
  }

  backend_http_settings {
    name                  = each.value.backend_http_settings_name
    cookie_based_affinity = each.value.cookie_based_affinity

    path     = each.value.backend_path
    port     = each.value.backend_port
    protocol = each.value.backend_protocol

    request_timeout = each.value.request_timeout

    probe_name = each.value.probe_name
  }

  probe {
    name     = each.value.probe_name
    protocol = each.value.probe_protocol
    path     = each.value.probe_path

    interval            = each.value.probe_interval
    timeout             = each.value.probe_timeout
    unhealthy_threshold = each.value.probe_unhealthy_threshold

    pick_host_name_from_backend_http_settings = each.value.pick_host_name_from_backend_http_settings
  }

  http_listener {
    name                           = each.value.http_listener_name
    frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
    frontend_port_name             = each.value.frontend_port_name

    protocol = each.value.listener_protocol
  }

  request_routing_rule {
    name = each.value.request_routing_rule_name

    priority  = each.value.request_routing_priority
    rule_type = each.value.request_routing_rule_type

    http_listener_name = each.value.http_listener_name

    backend_address_pool_name = each.value.backend_address_pool_name

    backend_http_settings_name = each.value.backend_http_settings_name
  }

  tags = each.value.tags

  lifecycle {
    prevent_destroy = true
  }
}
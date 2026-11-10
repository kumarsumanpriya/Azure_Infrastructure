variable "application_gateways" {
  description = "Configuration for Azure Application Gateways"

  type = map(object({

    name                = string
    location            = string
    resource_group_name = string

    subnet_id            = string
    public_ip_address_id = string

    sku_name = string
    sku_tier = string

    min_capacity = number
    max_capacity = number

    zones = optional(list(string), null)

    enable_http2 = optional(bool, true)

    frontend_port = number

    backend_address_pool_name = string
    backend_addresses         = list(string)

    backend_http_settings_name = string
    backend_port               = number
    backend_protocol           = string

    pick_host_name_from_backend_http_settings = optional(bool, true)

    request_timeout       = number
    cookie_based_affinity = string
    backend_path          = optional(string, null)

    probe_name                = string
    probe_path                = string
    probe_protocol            = string
    probe_interval            = number
    probe_timeout             = number
    probe_unhealthy_threshold = number

    frontend_ip_configuration_name = string
    frontend_port_name             = string

    http_listener_name = string
    listener_protocol  = string

    request_routing_rule_name = string
    request_routing_priority  = number
    request_routing_rule_type = string

    tags = map(string)

  }))

  validation {
    condition = alltrue([
      for gw in var.application_gateways :
      contains(["Standard_v2", "WAF_v2"], gw.sku_name)
    ])

    error_message = "SKU must be Standard_v2 or WAF_v2."
  }

  validation {
    condition = alltrue([
      for gw in var.application_gateways :
      contains(["Standard_v2", "WAF_v2"], gw.sku_tier)
    ])

    error_message = "SKU tier must be Standard_v2 or WAF_v2."
  }

  validation {
    condition = alltrue([
      for gw in var.application_gateways :
      gw.min_capacity >= 0 &&
      gw.max_capacity >= 2 &&
      gw.max_capacity <= 125 &&
      gw.min_capacity <= gw.max_capacity
    ])

    error_message = "Invalid Application Gateway autoscale capacity."
  }

  validation {
    condition = alltrue([
      for gw in var.application_gateways :
      contains(["Http", "Https"], gw.backend_protocol) &&
      contains(["Http", "Https"], gw.probe_protocol) &&
      contains(["Http", "Https"], gw.listener_protocol)
    ])

    error_message = "Protocols must be Http or Https."
  }
}
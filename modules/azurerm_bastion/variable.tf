variable "bastion_hosts" {
  description = "Configuration for Azure Bastion Hosts"

  type = map(object({

    name                = string
    location            = string
    resource_group_name = string

    subnet_id            = string
    public_ip_address_id = string

    sku = optional(string, "Standard")

    scale_units = optional(number, 2)

    copy_paste_enabled = optional(bool, true)

    file_copy_enabled = optional(bool, true)

    ip_connect_enabled = optional(bool, true)

    shareable_link_enabled = optional(bool, false)

    tunneling_enabled = optional(bool, true)

    tags = map(string)

  }))

  validation {
    condition = alltrue([
      for bastion in var.bastion_hosts :
      contains(["Basic", "Standard", "Premium"], bastion.sku)
    ])

    error_message = "Bastion SKU must be Basic, Standard, or Premium."
  }

  validation {
    condition = alltrue([
      for bastion in var.bastion_hosts :
      bastion.scale_units >= 2 &&
      bastion.scale_units <= 50
    ])

    error_message = "Bastion scale units must be between 2 and 50."
  }
}
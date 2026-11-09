variable "vms" {
  description = "Configuration for Azure Linux Virtual Machines"

  type = map(object({
    name                  = string
    location              = string
    resource_group        = string
    size                  = string
    subnet_name           = string
    vnet_name             = string
    subnet_resource_group = string
    key_vault_key         = string
    username_secret_name  = string
    password_secret_name  = string
    os_disk_type          = string
    tags                  = map(string)
  }))
}
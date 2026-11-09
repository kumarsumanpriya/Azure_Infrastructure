variable "key_vaults" {
  description = "Existing Azure Key Vault configurations"

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tenant_id           = string
    sku_name            = string

    enabled_for_disk_encryption   = bool
    soft_delete_retention_days    = number
    purge_protection_enabled      = bool
    public_network_access_enabled = bool
    rbac_authorization_enabled    = bool

    tags = map(string)
  }))
}
output "key_vaults" {
  description = "Azure Key Vault details"

  value = {
    for key, kv in azurerm_key_vault.key_vault : key => {
      id                  = kv.id
      name                = kv.name
      vault_uri           = kv.vault_uri
      resource_group_name = kv.resource_group_name
      location            = kv.location
      tenant_id           = kv.tenant_id
    }
  }
}

output "storage_accounts" {
  description = "Details of created Azure Storage Accounts"

  value = {
    for key, storage in azurerm_storage_account.sa : key => {
      id                  = storage.id
      name                = storage.name
      resource_group_name = storage.resource_group_name
      location            = storage.location
      account_tier        = storage.account_tier
      replication_type    = storage.account_replication_type
    }
  }
}
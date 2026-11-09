variable "storage_accounts" {
  type = map(object({
    name             = string
    resource_groups  = string
    location         = string
    replication_type = string
    account_tier     = string
    tags             = map(string)
  }))
  description = "Storage Account configuration"

}
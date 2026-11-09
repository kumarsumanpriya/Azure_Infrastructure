output "public_ip_details" {
  description = "Details of all Azure Public IP resources"

  value = {
    for key, ip in azurerm_public_ip.this : key => {
      id         = ip.id
      name       = ip.name
      ip_address = ip.ip_address
      fqdn       = ip.fqdn
      ip_version = ip.ip_version
    }
  }
}
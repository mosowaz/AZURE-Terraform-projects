output "storage_account_name" {
  value = {
    for i, j in azurerm_storage_account.storage : i => j.name
  }
  description = "output of both storage account names"
}

output "Bastion_Host_Public_IP_Address" {
  value = azurerm_public_ip.pub_ip.ip_address
}
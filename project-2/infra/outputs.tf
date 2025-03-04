output "storage_account1_name" {
  value = azurerm_storage_account.storage1.name
  description = "output of allowed storage account name"
}

output "storage_account2_name" {
  value = azurerm_storage_account.storage2.name
  description = "output of denied storage account name"
}

output "resource_group_id" {
  description = "The id of the created resource group."
  value       = azurerm_resource_group.rg.id
}

output "virtual_network_id" {
  value       = azurerm_virtual_network.vnet1.id
}

output "storage_accout_id" {
   value 	= azurerm_storage_account.storage.id
}

data "azurerm_public_ip" "pub-ip" {
  name                = azurerm_public_ip.pub-ip.name
  resource_group_name = azurerm_resource_group.rg.name
}

output "bastion_public_ip_address" {
   value        = data.azurerm_public_ip.pub-ip.ip_address
}

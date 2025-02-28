output "resource_group_id" {
  description = "The id of the created resource group."
  value       = azurerm_resource_group.rg.id
}

output "virtual_network_id" {
  value = azurerm_virtual_network.vnet1.id
}

data "azurerm_public_ip" "pub-ip" {
  name                = azurerm_public_ip.pub-ip.name
  resource_group_name = azurerm_resource_group.rg.name
}

output "bastion_public_ip_address" {
  value = data.azurerm_public_ip.pub-ip.ip_address
}

output "bastion_public_ip_address_id" {
  value = data.azurerm_public_ip.pub-ip.id
}

output "nsg_association_1" {
  value = azurerm_subnet_network_security_group_association.nsg-association-1.id
}

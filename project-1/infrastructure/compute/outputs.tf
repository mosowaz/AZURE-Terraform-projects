output "hub_public_ip" {
  value = azurerm_public_ip.hub_pub_ip.ip_address
}

output "hub_private_ip" {
  value = azurerm_network_interface.hub-nic.private_ip_address
}

output "spokes_private_ip" {
  value = {
    for i, j in azurerm_network_interface.spoke-nic : i => j.private_ip_address
  }
}

output "spoke1_public_ip" {
  value = azurerm_public_ip.spoke1_pub_ip.ip_address
}

output "spoke2_public_ip" {
  value = azurerm_public_ip.spoke2_pub_ip.ip_address
}
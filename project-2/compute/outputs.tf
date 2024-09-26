output "hub_public_ip" {
  value = azurerm_public_ip.pub_ip.ip_address
}

output "hub_private_ip" {
  value = azurerm_network_interface.hub-nic.private_ip_address
}

output "spokes_private_ip" {
  value = {
    for i, j in azurerm_network_interface.spoke-nic : i => j.private_ip_address
  }
}


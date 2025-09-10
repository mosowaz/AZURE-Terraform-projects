# Get current IP address for use in KV firewall rules
data "http" "ip" {
  url = "https://api.ipify.org/"
  retry {
    attempts     = 5
    max_delay_ms = 1000
    min_delay_ms = 500
  }
}

#----------------jumpbox nsg ssh inbound-------------------
resource "azurerm_network_security_group" "jumpbox_nsg" {
  name                = "jumpbox-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "jumpbox_rule1" {
  name                        = "jumpbox-rule1"
  priority                    = 400
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 22
  source_address_prefix       = data.http.ip.response_body
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.jumpbox_nsg.name

  depends_on = [ azurerm_linux_virtual_machine.jumpbox_vm ]
}

resource "azurerm_network_interface_security_group_association" "ssh_in_assoc" {
  network_interface_id      = azurerm_network_interface.jumpbox_nic.id
  network_security_group_id = azurerm_network_security_group.jumpbox_nsg.id
}

#------------------- agw to backend pools 80/443 inbound access--------------------
resource "azurerm_network_security_group" "backend_nsg" {
  name                = "backend-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "backend_rule" {
  name                        = "backend-allow-80-443"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = [80, 443]
  source_address_prefixes     = azurerm_subnet.frontend.address_prefixes
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.backend_nsg.name

  depends_on = [
    azurerm_linux_virtual_machine_scale_set.backend1,
    azurerm_linux_virtual_machine_scale_set.backend2,
    azurerm_linux_virtual_machine_scale_set.backend3
  ]
}

resource "azurerm_subnet_network_security_group_association" "backend_inbound_assoc" {
  subnet_id                 = azurerm_subnet.backend.id
  network_security_group_id = azurerm_network_security_group.backend_nsg.id
}
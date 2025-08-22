# Get current IP address for use in KV firewall rules
data "http" "ip" {
  url = "https://api.ipify.org/"
  retry {
    attempts     = 5
    max_delay_ms = 1000
    min_delay_ms = 500
  }
}

resource "azurerm_network_security_group" "jumpbox_nsg" {
  name                = "jumpbox-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "jumpbox_rule1" {
  name                         = "jumpbox-rule1"
  priority                     = 400
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = 22
  source_address_prefix        = data.http.ip.response_body
  destination_address_prefixes = azurerm_linux_virtual_machine.linux_vm.public_ip_addresses
  resource_group_name          = azurerm_resource_group.rg.name
  network_security_group_name  = azurerm_network_security_group.jumpbox_nsg.name
}
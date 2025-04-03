# Create NSGs
resource "azurerm_network_security_group" "nsg" {
  count               = 2
  name                = "nsg-${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# NSG for internal lb subnet
resource "azurerm_network_security_rule" "nsg_1_rules" {
  for_each                    = local.nsg_1_rules
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg[0].name
}

resource "azurerm_subnet_network_security_group_association" "nsg-1-association" {
  subnet_id                 = data.azurerm_subnet.int_lb_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg[0].id
}

# NSG for external lb subnet
resource "azurerm_network_security_rule" "nsg_2_rules" {
  for_each                    = local.nsg_2_rules
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg[1].name
}

resource "azurerm_subnet_network_security_group_association" "nsg-2-association" {
  subnet_id                 = data.azurerm_subnet.ext_lb_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg[1].id
}
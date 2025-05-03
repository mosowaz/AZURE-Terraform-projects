# Create NSGs
resource "azurerm_network_security_group" "nsg" {
  count               = 3
  name                = "nsg-${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# NSG rule (Allow inbound HTTP/HTTPS) for internal load balancer subnet
resource "azurerm_network_security_rule" "nsg_1_rule_1" {
  for_each                    = var.nsg-1-rule-1
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_ranges     = try(each.value.destination_port_ranges, [80, 443])
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg[0].name
}

# # NSG rule (Allow inbound RDP) for internal load balancer subnet
# resource "azurerm_network_security_rule" "nsg_1_rule_2" {
#   name                        = var.nsg-1-rule-2.name
#   priority                    = var.nsg-1-rule-2.priority
#   direction                   = var.nsg-1-rule-2.direction
#   access                      = var.nsg-1-rule-2.access
#   protocol                    = var.nsg-1-rule-2.protocol
#   source_port_range           = var.nsg-1-rule-2.source_port_range
#   destination_port_range      = var.nsg-1-rule-2.destination_port_range
#   source_address_prefix       = var.nsg-1-rule-2.source_address_prefix
#   destination_address_prefix  = var.nsg-1-rule-2.destination_address_prefix
#   resource_group_name         = azurerm_resource_group.rg.name
#   network_security_group_name = azurerm_network_security_group.nsg[0].name
# }

# NSG rule (Allow outbound access on ports 80 and 443) for internal load balancer subnet
resource "azurerm_network_security_rule" "nsg_1_rule_2" {
  name                        = var.nsg-1-rule-2.name
  priority                    = var.nsg-1-rule-2.priority
  direction                   = var.nsg-1-rule-2.direction
  access                      = var.nsg-1-rule-2.access
  protocol                    = var.nsg-1-rule-2.protocol
  source_port_range           = var.nsg-1-rule-2.source_port_range
  destination_port_ranges     = try(var.nsg-1-rule-2.destination_port_ranges, [80, 443])
  source_address_prefix       = var.nsg-1-rule-2.source_address_prefix
  destination_address_prefix  = var.nsg-1-rule-2.destination_address_prefix
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg[0].name
}

resource "azurerm_subnet_network_security_group_association" "nsg-1-association" {
  subnet_id                 = data.azurerm_subnet.int_lb_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg[0].id
}

# NSG rule (Allow inbound HTTP/HTTPS) for external load balancer subnet
resource "azurerm_network_security_rule" "nsg_2_rule_1" {
  for_each                    = var.nsg-2-rule-1
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_ranges     = try(each.value.destination_port_ranges, [80, 443])
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg[1].name
}

# # NSG rule (Allow inbound RDP) for external load balancer subnet
# resource "azurerm_network_security_rule" "nsg_2_rule_2" {
#   name                        = var.nsg-2-rule-2.name
#   priority                    = var.nsg-2-rule-2.priority
#   direction                   = var.nsg-2-rule-2.direction
#   access                      = var.nsg-2-rule-2.access
#   protocol                    = var.nsg-2-rule-2.protocol
#   source_port_range           = var.nsg-2-rule-2.source_port_range
#   destination_port_range      = var.nsg-2-rule-2.destination_port_range
#   source_address_prefix       = var.nsg-2-rule-2.source_address_prefix
#   destination_address_prefix  = var.nsg-2-rule-2.destination_address_prefix
#   resource_group_name         = azurerm_resource_group.rg.name
#   network_security_group_name = azurerm_network_security_group.nsg[1].name
# }

# NSG rule (Allow all outbound access to ports 80 and 443) for enternal load balancer subnet
resource "azurerm_network_security_rule" "nsg_2_rule_3" {
  name                        = var.nsg-2-rule-2.name
  priority                    = var.nsg-2-rule-2.priority
  direction                   = var.nsg-2-rule-2.direction
  access                      = var.nsg-2-rule-2.access
  protocol                    = var.nsg-2-rule-2.protocol
  source_port_range           = var.nsg-2-rule-2.source_port_range
  destination_port_ranges     = try(var.nsg-2-rule-2.destination_port_range, [80, 443])
  source_address_prefix       = var.nsg-2-rule-2.source_address_prefix
  destination_address_prefix  = var.nsg-2-rule-2.destination_address_prefix
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg[1].name
}

resource "azurerm_subnet_network_security_group_association" "nsg-2-association" {
  subnet_id                 = data.azurerm_subnet.ext_lb_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg[1].id
}



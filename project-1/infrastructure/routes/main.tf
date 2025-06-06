resource "azurerm_resource_group" "rg1" {
  name     = "rg-${var.location1}-routes"
  location = var.location1
}

resource "azurerm_resource_group" "rg2" {
  name     = "rg-${var.location2}-routes"
  location = var.location2
}

resource "azurerm_network_security_group" "hub-nsg" {
  name                = "hub-inbound-ssh"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_network_security_rule" "hub-rule1" {
    name                       = "hub-outbound-private"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*" #Any IP in the subnet associated with NSG rule
    destination_address_prefixes = [ var.spoke1_address_prefix, var.spoke2_address_prefix ] #spokes address prefix
    resource_group_name         = azurerm_resource_group.rg1.name
    network_security_group_name = azurerm_network_security_group.hub-nsg.name 
}

resource "azurerm_network_security_rule" "hub-rule2" {
    name                       = "hub-inbound-public"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.mypublic-ip
    destination_address_prefix = "*" #Any IP in the subnet associated with NSG rule
    resource_group_name         = azurerm_resource_group.rg1.name
    network_security_group_name = azurerm_network_security_group.hub-nsg.name 
}

resource "azurerm_subnet_network_security_group_association" "hub-rule-association" {
  subnet_id                 = data.azurerm_subnet.subnet1.id
  network_security_group_id = data.azurerm_network_security_group.hub-nsg.id
}

resource "azurerm_network_security_group" "spoke1-nsg" {
  name                = "spoke1-inbound-ssh"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
}

resource "azurerm_network_security_group" "spoke2-nsg" {
  name                = "spoke2-inbound-ssh"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_network_security_rule" "spoke1-rule" {
    name                       = "spoke-inbound-public"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.mypublic-ip
    destination_address_prefix = "*" #Any IP in the subnet associated with NSG rule
    resource_group_name         = azurerm_resource_group.rg2.name
    network_security_group_name = azurerm_network_security_group.spoke1-nsg.name 
}

resource "azurerm_network_security_rule" "spoke2-rule" {
    name                       = "spoke-inbound-public"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.mypublic-ip
    destination_address_prefix = "*" #Any IP in the subnet associated with NSG rule
    resource_group_name         = azurerm_resource_group.rg1.name
    network_security_group_name = azurerm_network_security_group.spoke2-nsg.name 
}


resource "azurerm_subnet_network_security_group_association" "spoke1-rule-association" {
  subnet_id                 = data.azurerm_subnet.subnet2.id
  network_security_group_id = data.azurerm_network_security_group.spoke1-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "spoke2-rule-association" {
  subnet_id                 = data.azurerm_subnet.subnet3.id
  network_security_group_id = data.azurerm_network_security_group.spoke2-nsg.id
}

resource "azurerm_route_table" "spoke1-2" {
  name                = var.rt-spoke1-2
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name

  route {
    name                   = var.rt-spoke1-2
    address_prefix         = var.spoke2_address_prefix # to spoke2 network address
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.hub_ip
  }
}

resource "azurerm_subnet_route_table_association" "spoke1-association" {
  subnet_id      = data.azurerm_subnet.subnet2.id
  route_table_id = data.azurerm_route_table.spoke1-2.id
}

resource "azurerm_route_table" "spoke2-1" {
  name                = var.rt-spoke1-2
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  route {
    name                   = var.rt-spoke2-1
    address_prefix         = var.spoke1_address_prefix #to spoke1 network address
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.hub_ip
  }
}

resource "azurerm_subnet_route_table_association" "spoke2-association" {
  subnet_id      = data.azurerm_subnet.subnet3.id
  route_table_id = data.azurerm_route_table.spoke2-1.id
}

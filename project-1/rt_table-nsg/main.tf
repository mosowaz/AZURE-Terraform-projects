resource "azurerm_resource_group" "rg1" {
  name = "${var.location1}-rt-rg"
  location = var.location1
  tags = {
    resource = "${var.lab_tag}-central-rg"
  }
}

resource "azurerm_resource_group" "rg2" {
  name = "${var.location2}-rt-rg"
  location = var.location2
  tags = {
    resource = "${var.lab_tag}-east-rg"
  }
}

resource "azurerm_network_security_group" "hub-nsg" {
  name                = "inbound-ssh-connection"
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
    destination_address_prefixes = [ "172.16.1.0/24", "192.168.1.0/24"] #spoke subnets
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
    source_address_prefix      = var.mypublic_ip
    destination_address_prefix = "*" #Any IP in the subnet associated with NSG rule
    resource_group_name         = azurerm_resource_group.rg1.name
    network_security_group_name = azurerm_network_security_group.hub-nsg.name 
}

resource "azurerm_subnet_network_security_group_association" "hub-rule-association" {
  subnet_id                 = data.terraform_remote_state.network.outputs.subnets.subnet1.subnet_id
  network_security_group_id = data.azurerm_network_security_group.hub-nsg.id
}

resource "azurerm_route_table" "spoke1-2" {
  name                = var.rt-spoke1-2
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name

  route {
    name                   = var.rt-spoke1-2
    address_prefix         = "192.168.1.0/24" # to spoke2 subnet
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = data.terraform_remote_state.compute.outputs.hub_private_ip
  }
}

resource "azurerm_subnet_route_table_association" "spoke1-association" {
  subnet_id      = data.terraform_remote_state.network.outputs.subnets.subnet2.subnet_id
  route_table_id = data.azurerm_route_table.spoke1-2.id
}

resource "azurerm_route_table" "spoke2-1" {
  name                = var.rt-spoke1-2
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  route {
    name                   = var.rt-spoke2-1
    address_prefix         = "172.16.1.0/24" #to spoke1 subnet
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = data.terraform_remote_state.compute.outputs.hub_private_ip
  }
}

resource "azurerm_subnet_route_table_association" "spoke2-association" {
  subnet_id      = data.terraform_remote_state.network.outputs.subnets.subnet3.subnet_id
  route_table_id = data.azurerm_route_table.spoke2-1.id
}

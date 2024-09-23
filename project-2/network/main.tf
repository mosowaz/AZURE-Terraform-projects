resource "azurerm_resource_group" "rg1" {
  name     = var.rg1.name
  location = var.rg1.location
  tags = {
    intersite_network = "${var.lab_tag}-hub-spoke"
  }
}

resource "azurerm_resource_group" "rg2" {
  name     = var.rg2.name
  location = var.rg2.location
  tags = {
    intersite_network = "${var.lab_tag}-spoke"
  }
}

resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet_peering-1.vnet_name
  address_space       = [var.vnet_peering-1.address_space]
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags = {
    intersite_network = "${var.lab_tag}-hub"
  }
}

resource "azurerm_virtual_network" "vnet2" {
  name                = var.vnet_peering-2.vnet_name
  address_space       = [var.vnet_peering-2.address_space]
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  tags = {
    intersite_network = "${var.lab_tag}-spoke1"
  }
}

resource "azurerm_virtual_network" "vnet3" {
  name                = var.vnet_peering-3.vnet_name
  address_space       = [var.vnet_peering-3.address_space]
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags = {
    intersite_network = "${var.lab_tag}-spoke2"
  }
}

resource "azurerm_virtual_network_peering" "peering1-2" {
  name                      = format("peering-%s-to-%s", var.vnet_peering-1.vnet_name, var.vnet_peering-2.vnet_name)
  resource_group_name       = azurerm_virtual_network.vnet1.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
}

resource "azurerm_virtual_network_peering" "peering2-1" {
  name                      = format("peering-%s-to-%s", var.vnet_peering-2.vnet_name, var.vnet_peering-1.vnet_name)
  resource_group_name       = azurerm_virtual_network.vnet1.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
}

resource "azurerm_virtual_network_peering" "peering1-3" {
  name                      = format("peering-%s-to-%s", var.vnet_peering-1.vnet_name, var.vnet_peering-3.vnet_name)
  resource_group_name       = azurerm_virtual_network.vnet1.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet3.id
  allow_virtual_network_access = true
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
}

resource "azurerm_virtual_network_peering" "peering3-1" {
  name                      = format("peering-%s-to-%s", var.vnet_peering-3.vnet_name, var.vnet_peering-1.vnet_name)
  resource_group_name       = azurerm_virtual_network.vnet3.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet3.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
}
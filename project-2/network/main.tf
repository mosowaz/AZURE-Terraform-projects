resource "azurerm_resource_group" "rg1" {
  name     = "rg-${var.location1}"
  location = var.location1
  tags = {
    intersite_network = "${var.lab_tag}-peering-central"
  }
}

resource "azurerm_resource_group" "rg2" {
  name     = "rg-${var.location2}"
  location = var.location2
  tags = {
    intersite_network = "${var.lab_tag}-peering-east"
  }
}

resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet1.vnet_name
  address_space       = [var.vnet1.address_space]
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags = {
    intersite_network = "${var.lab_tag}-hub"
  }
}

resource "azurerm_virtual_network" "vnet2" {
  name                = var.vnet2.vnet_name
  address_space       = [var.vnet2.address_space]
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  tags = {
    intersite_network = "${var.lab_tag}-spoke1"
  }
}

resource "azurerm_virtual_network" "vnet3" {
  name                = var.vnet3.vnet_name
  address_space       = [var.vnet3.address_space]
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags = {
    intersite_network = "${var.lab_tag}-spoke2"
  }
}

resource "azurerm_virtual_network_peering" "peering1-2" {
  name                      = format("peering-%s-to-%s", var.vnet1.vnet_name, var.vnet2.vnet_name)
  resource_group_name       = azurerm_virtual_network.vnet1.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  depends_on = [ azurerm_virtual_network.vnet1, data.azurerm_virtual_network.vnet2 ]
}

resource "azurerm_virtual_network_peering" "peering2-1" {
  name                      = format("peering-%s-to-%s", var.vnet2.vnet_name, var.vnet1.vnet_name)
  resource_group_name       = azurerm_virtual_network.vnet2.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  depends_on = [ azurerm_virtual_network.vnet2, data.azurerm_virtual_network.vnet1 ]
}

resource "azurerm_virtual_network_peering" "peering1-3" {
  name                      = format("peering-%s-to-%s", var.vnet1.vnet_name, var.vnet3.vnet_name)
  resource_group_name       = azurerm_virtual_network.vnet1.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet3.id
  allow_virtual_network_access = true
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  depends_on = [ azurerm_virtual_network.vnet1, data.azurerm_virtual_network.vnet3 ]
}

resource "azurerm_virtual_network_peering" "peering3-1" {
  name                      = format("peering-%s-to-%s", var.vnet3.vnet_name, var.vnet1.vnet_name)
  resource_group_name       = azurerm_virtual_network.vnet3.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet3.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  depends_on = [ azurerm_virtual_network.vnet3, data.azurerm_virtual_network.vnet1 ]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "${var.vnet1.vnet_name}-subnet"
  resource_group_name  = azurerm_virtual_network.vnet1.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.vnet1.address_prefixes]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "${var.vnet1.vnet_name}-subnet"
  resource_group_name  = azurerm_virtual_network.vnet2.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = [var.vnet2.address_prefixes]
}

resource "azurerm_subnet" "subnet3" {
  name                 = "${var.vnet3.vnet_name}-subnet"
  resource_group_name  = azurerm_virtual_network.vnet3.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet3.name
  address_prefixes     = [var.vnet3.address_prefixes]
}
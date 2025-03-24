data "azurerm_resource_group" "net_rg1" {
  name = "rg-${var.location1}-network"
}

data "azurerm_resource_group" "net_rg2" {
  name = "rg-${var.location2}-network"
}

data "azurerm_subnet" "subnet1" {
  name                 = "vnet-1-subnet"
  virtual_network_name = "vnet-1"
  resource_group_name  = data.azurerm_resource_group.net_rg1.name
}

data "azurerm_subnet" "subnet2" {
  name                 = "vnet-2-subnet"
  virtual_network_name = "vnet-2"
  resource_group_name  = data.azurerm_resource_group.net_rg2.name
}

data "azurerm_subnet" "subnet3" {
  name                 = "vnet-3-subnet"
  virtual_network_name = "vnet-3"
  resource_group_name  = data.azurerm_resource_group.net_rg1.name
}

data "azurerm_network_interface" "hub-nic" {
  name                = azurerm_network_interface.hub-nic.name
  resource_group_name = azurerm_network_interface.hub-nic.resource_group_name
}

data "azurerm_network_interface" "spoke-nic" {
  for_each            = azurerm_network_interface.spoke-nic
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_public_ip" "hub_pub_ip" {
  name                = azurerm_public_ip.hub_pub_ip.name
  resource_group_name = azurerm_public_ip.hub_pub_ip.resource_group_name
}

data "azurerm_public_ip" "spoke1_pub_ip" {
  name                = azurerm_public_ip.spoke1_pub_ip.name
  resource_group_name = azurerm_public_ip.spoke1_pub_ip.resource_group_name
}

data "azurerm_public_ip" "spoke2_pub_ip" {
  name                = azurerm_public_ip.spoke2_pub_ip.name
  resource_group_name = azurerm_public_ip.spoke2_pub_ip.resource_group_name
}
resource "azurerm_resource_group" "rg" {
  for_each = var.vnet_address_space
  name     = "rg-${each.value.location}"
  location = each.value.location
  tags = {
    intersite_network = var.lab_tag
  }
}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnet_address_space
  name                = "vnet-${each.value.location}"
  address_space       = [each.value.address_space]
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  tags = {
    intersite_network = var.lab_tag
  }
}

resource "azurerm_virtual_network_peering" "peering" {
  for_each                  = var.vnet_address_space
  name                      = format("peering-%s-to-%s", var.vnet_address_space.vnet-1.location, var.vnet_address_space.vnet-2.location)
  resource_group_name       = azurerm_resource_group.rg[each.key].name
  virtual_network_name      = azurerm_virtual_network.vnet[each.key].name
  remote_virtual_network_id = azurerm_virtual_network.vnet[each.key].id
  allow_virtual_network_access = true
  allow_forwarded_traffic   = true

  allow_gateway_transit     = false  
}
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
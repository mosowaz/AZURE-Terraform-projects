resource "azurerm_resource_group" "rg" {
  for_each = var.location
  name     = var.rg_name
  location = each.key

  tags     = {
    intersite_network = var.lab_tag
  }
}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnet_address_space
  name                = each.value.name
  address_space       = each.value.address_space
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg.name

  tags     = {
    intersite_network = var.lab_tag
  }
}
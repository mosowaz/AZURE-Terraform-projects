# Create vnet for internal LB backend pool 
resource "azurerm_virtual_network" "vnet_int" {
  name                = var.vnet-int.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnet-int.address_space]
  dns_servers         = ["8.8.8.8", "9.9.9.9"]

  subnet {
    name             = var.vnet-int.subnet_name
    address_prefixes = [var.vnet-int.subnet_address_prefixes]
  }
}

# Create vnet for external LB backend pool 
resource "azurerm_virtual_network" "vnet_ext" {
  name                = var.vnet-ext.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnet-ext.address_space]
  dns_servers         = ["8.8.8.8", "9.9.9.9"]

  subnet {
    name             = var.vnet-ext.subnet_name
    address_prefixes = [var.vnet-ext.subnet_address_prefixes]
  }
}


# Create vnet for internal backend pool 
resource "azurerm_virtual_network" "vnet-int" {
  name                = var.vnet-int.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet-int.address_space
  dns_servers         = ["8.8.8.8", "9.9.9.9"]
}

# Create vnet for external backend pool 
resource "azurerm_virtual_network" "vnet-ext" {
  name                = var.vnet-ext.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet-ext.address_space
  dns_servers         = ["8.8.8.8", "9.9.9.9"]
}
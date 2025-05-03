# Create vnet for both internal and external LB backend pools 
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnet.address_space]
  dns_servers         = ["168.63.129.16", "9.9.9.9"]

  subnet {
    name             = var.vnet.subnet_name_int
    address_prefixes = [var.vnet.subnet_address_prefixes_int]
  }

  subnet {
    name             = var.vnet.subnet_name_ext
    address_prefixes = [var.vnet.subnet_address_prefixes_ext]
  }
}

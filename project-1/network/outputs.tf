output "subnets" {
    value = {
      subnet1 = {
        name             = azurerm_subnet.subnet1.name
        subnet_id        = azurerm_subnet.subnet1.id
        address_prefixes = azurerm_subnet.subnet1.address_prefixes
      }
      subnet2 = {
        name             = azurerm_subnet.subnet2.name
        subnet_id        = azurerm_subnet.subnet2.id
        address_prefixes = azurerm_subnet.subnet2.address_prefixes
      }
      subnet3 = {
        name             = azurerm_subnet.subnet3.name
        subnet_id        = azurerm_subnet.subnet3.id
        address_prefixes = azurerm_subnet.subnet3.address_prefixes
      }
    }
}
output "rg" {
  value = {
    rg1 = { 
      name = azurerm_resource_group.rg1.name
      location = azurerm_resource_group.rg1.location 
      id = azurerm_resource_group.rg1.id 
    }
    rg2 = { 
      name = azurerm_resource_group.rg2.name
      location = azurerm_resource_group.rg2.location 
      id = azurerm_resource_group.rg2.id 
    }
  }
}

output "subnets" {
    value = {
      subnet1 = {
        name             = azurerm_subnet.subnet1.name
        subnet_id        = azurerm_subnet.subnet1.id
      }
      subnet2 = {
        name             = azurerm_subnet.subnet2.name
        subnet_id        = azurerm_subnet.subnet2.id
      }
      subnet3 = {
        name             = azurerm_subnet.subnet3.name
        subnet_id        = azurerm_subnet.subnet3.id
      }
    }
}
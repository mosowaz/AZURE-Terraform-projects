resource "azurerm_resource_group" "rg" {
  name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
}
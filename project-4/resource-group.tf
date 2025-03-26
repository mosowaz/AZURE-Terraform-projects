resource "azurerm_resource_group" "rg" {
  name     = var.lb-rg-name
  location = var.lb-rg-location
}
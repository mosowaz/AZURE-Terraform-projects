resource "azurerm_resource_group" "rg" {
  name     = var.lb-rg-name
  location = var.lb-rg-location
}

module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming.git?ref=75d5afae4cb01f4446025e81f76af6b60c1f927b"
}
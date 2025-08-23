resource "azurerm_resource_group" "rg" {
  name     = "agw"
  location = "canadacentral"
}

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming.git?ref=75d5afae"
}  
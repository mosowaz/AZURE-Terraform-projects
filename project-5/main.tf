resource "azurerm_resource_group" "rg" {
  name     = "agw"
  location = "canadacentral"
}

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"
  suffix  = ["agw"]
}  
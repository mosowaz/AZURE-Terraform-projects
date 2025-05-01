# This is needed this to get the object_id of the current user
data "azurerm_client_config" "current" {}

# Use the role definition data source to get the id of the Contributor role
data "azurerm_role_definition" "contributor_role" {
  name = "Contributor"
}

# Use the role definition data source to get the id of the Owner role
data "azurerm_role_definition" "owner_role" {
  name = "Owner"
}

# Needed to get the object_id of SPN
data "azuread_service_principal" "spn" {
  display_name = "SPN-ADO-2"
}

data "azurerm_subscription" "primary" {
}

data "azurerm_subnet" "ext_lb_subnet" {
  name                 = var.vnet.subnet_name_ext
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
}

data "azurerm_subnet" "int_lb_subnet" {
  name                 = var.vnet.subnet_name_int
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
}


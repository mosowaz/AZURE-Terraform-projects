# We need this to get the object_id of the current user
data "azurerm_client_config" "current" {}

# We use the role definition data source to get the id of the Contributor role
data "azurerm_role_definition" "role" {
  name = "Contributor"
}

data "azurerm_resource_group" "rg" {
  name = "RG-ServiceEndpoint"
}

data "azurerm_user_assigned_identity" "vm" {
  name                = azurerm_user_assigned_identity.vm.name
  resource_group_name = azurerm_resource_group.rg.name
  depends_on          = [azurerm_resource_group.rg, azurerm_user_assigned_identity.vm]
}

data "azurerm_subnet" "BastionSubnet" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = "vnet-SEP"
  resource_group_name  = "RG-ServiceEndpoint"
}

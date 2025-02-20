# We need this to get the object_id of the current user
data "azurerm_client_config" "current" {}

# We use the role definition data source to get the id of the Contributor role
data "azurerm_role_definition" "role" {
  name = "Contributor"
}

data "azurerm_user_assigned_identity" "vm" {
  name                = azurerm_user_assigned_identity.vm.name
  resource_group_name = azurerm_resource_group.rg.name
  depends_on          = [azurerm_resource_group.rg, azurerm_user_assigned_identity.vm]
}

# Bastion Host Public IP
data "azurerm_public_ip" "pub_ip" {
  name                = azurerm_public_ip.pub_ip.name
  resource_group_name = azurerm_resource_group.rg.name
  depends_on          = [azurerm_resource_group.rg]
}

data "azurerm_subnet" "BastionSubnet" {
  name                 = module.avm-res-network-virtualnetwork.subnets.subnet1.name
  virtual_network_name = module.avm-res-network-virtualnetwork.name
  resource_group_name  = azurerm_resource_group.rg.name

  depends_on = [azurerm_resource_group.rg, module.avm-res-network-virtualnetwork]
}

data "azurerm_resource_group" "rg" {
  name = "RG-ServiceEndpoint"
}

# Bastion Host Public IP
data "azurerm_public_ip" "pub_ip" {
  name                = azurerm_public_ip.pub_ip.name
  resource_group_name = azurerm_resource_group.rg.name
  depends_on          = [azurerm_resource_group.rg]
}

data "azurerm_subnet" "BastionSubnet" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = "vnet-SEP"
  resource_group_name  = "RG-ServiceEndpoint-Network"
}
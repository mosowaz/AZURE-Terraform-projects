data "azurerm_subnet" "BastionSubnet" {
  name                 = module.avm-res-network-virtualnetwork.subnets.subnet1.name
  virtual_network_name = module.avm-res-network-virtualnetwork.name
  resource_group_name  = azurerm_resource_group.rg.name

  depends_on = [azurerm_resource_group.rg, module.avm-res-network-virtualnetwork]
}

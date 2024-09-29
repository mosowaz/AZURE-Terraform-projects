data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../network/terraform.tfstate"
  }
}

data "terraform_remote_state" "compute" {
  backend = "local"
  config = {
    path = "../compute/terraform.tfstate"
  }
}

data "azurerm_network_security_group" "hub-nsg" {
  name                = azurerm_network_security_group.hub-nsg.name
  resource_group_name = azurerm_resource_group.rg1.name
}

data "azurerm_route_table" "spoke1-2" {
  name                = azurerm_route_table.spoke1-2.name
  resource_group_name = azurerm_resource_group.rg2.name
}

data "azurerm_route_table" "spoke2-1" {
  name                = azurerm_route_table.spoke2-1.name
  resource_group_name = azurerm_resource_group.rg1.name
}
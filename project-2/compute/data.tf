data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../network/terraform.tfstate"
  }
}

data "azurerm_network_interface" "hub-nic" {
  name                = azurerm_network_interface.hub-nic.name
  resource_group_name = azurerm_network_interface.hub-nic.resource_group_name
}

data "azurerm_network_interface" spoke-nic {
  for_each = azurerm_network_interface.spoke-nic
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}
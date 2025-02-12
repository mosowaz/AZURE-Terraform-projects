resource "azurerm_resource_group" "rg" {
  name = var.resource_group.name
  location = var.resource_group.location
}

module "avm-res-network-virtualnetwork" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"

  address_space       = [var.vnet.address_space]
  location            = azurerm_resource_group.rg.location
  name                = var.vnet.name
  resource_group_name = azurerm_resource_group.rg.name
  subnets = {
    "subnet1" = {
      name             = "subnet1"
      address_prefixes = ["10.0.0.0/24"]
      service_endpoints = ["Microsoft.Storage"]
      /*service_endpoint_policies = {
        policy1 = {
          id = azurerm_subnet_service_endpoint_storage_policy.this.id
        }
      }*/
    }
  }
  dns_servers = {
    dns_servers = ["8.8.8.8"]
  }
}
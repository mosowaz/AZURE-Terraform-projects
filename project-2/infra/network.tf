# Create vnet and subnet. Enable service endpoint in the subnet (AzureBastionSubnet)
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnet.address_space]
  dns_servers         = ["8.8.8.8"]
  subnet {
    name             = "AzureBastionSubnet"
    address_prefixes = [var.BastionSubnet]
    service_endpoints = ["Microsoft.Storage"]
  }
}

# The policy ensures users in the subnet can only access safe and allowed Azure Storage accounts.
resource "azurerm_subnet_service_endpoint_storage_policy" "policy" {
  name                = "serviceEP_policy"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  definition {
    name        = "storageAcctPolicy"
    description = "policy to allow access to valid storage account"
    service     = "Microsoft.Storage"
    service_resources = [
      azurerm_resource_group.rg.id,
      azurerm_storage_account.storage[storage_account1].id # allow access to only "storage_account1"
    ]
  }
}

resource "azurerm_role_assignment" "role1" {
  scope                            = azurerm_resource_group.rg.id
  role_definition_name             = "Owner"
  principal_id                     = data.azurerm_client_config.example.object_id
  skip_service_principal_aad_check = false
}

resource "azurerm_role_assignment" "role2" {
  scope                            = azurerm_resource_group.rg.id
  role_definition_name             = data.azurerm_role_definition.role.name
  principal_id                     = data.azurerm_client_config.example.object_id
  skip_service_principal_aad_check = false
}
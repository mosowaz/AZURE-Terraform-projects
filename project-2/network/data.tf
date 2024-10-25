data "azurerm_key_vault_secret" "client_id" {
  name         = "SPN-client-id"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "client_secret" {
  name         = "SPN-client-secret"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "subscription_id" {
  name         = "SPN-subscription-id"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "tenant_id" {
  name         = "SPN-tenant-id"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_virtual_network" "vnet1" {
  name = azurerm_virtual_network.vnet1.name
  resource_group_name = azurerm_virtual_network.vnet1.resource_group_name
}

data "azurerm_virtual_network" "vnet2" {
  name = azurerm_virtual_network.vnet2.name
  resource_group_name = azurerm_virtual_network.vnet2.resource_group_name
}

data "azurerm_virtual_network" "vnet3" {
  name = azurerm_virtual_network.vnet3.name
  resource_group_name = azurerm_virtual_network.vnet3.resource_group_name
}

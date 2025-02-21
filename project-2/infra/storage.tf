# To be used in storage_account resource block
module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming.git?ref=75d5afae4cb01f4446025e81f76af6b60c1f927b"
  suffix = ["storageacct"]
}

resource "azurerm_user_assigned_identity" "vm" {
  location            = azurerm_resource_group.rg.location
  name                = module.naming.user_assigned_identity.name_unique
  resource_group_name = azurerm_resource_group.rg.name
}

# allowed and denied storage accounts with FileStorage type
resource "azurerm_storage_account" "storage" {
  for_each   = var.storage

  name                            = "${each.value.prefix}${module.naming.storage_account.name_unique}"
  resource_group_name             = azurerm_resource_group.rg[each.key].name
  location                        = azurerm_resource_group.rg[each.key].location
  account_tier                    = "Premium"
  account_replication_type        = "GRS"
  account_kind                    = "FileStorage"
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  shared_access_key_enabled       = true
  public_network_access_enabled   = false
  default_to_oauth_authentication = true
  local_user_enabled              = false

  identity {
    type         = ["SystemAssigned", "UserAssigned"]
    identity_ids = [azurerm_user_assigned_identity.vm[each.key].id]
    principal_id = data.azurerm_client_config.current[each.key].object_id
  }
}

# create file share in each storage account
resource "azurerm_storage_share" "shares" {
  for_each = var.storage

  name               = each.value.file_share
  storage_account_id = azurerm_storage_account.storage[each.key].id
  quota              = 10
}

# Deny all access to the storage accounts, and allow only access from selected subnet
resource "azurerm_storage_account_network_rules" "net_rules" {
  storage_account_id         = azurerm_storage_account.storage.id
  default_action             = "Deny"
  ip_rules                   = azurerm_virtual_network.vnet.subnet.address_prefixes
  virtual_network_subnet_ids = azurerm_virtual_network.vnet.subnet.id
  bypass                     = ["AzureServices"]
}
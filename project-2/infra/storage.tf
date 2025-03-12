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

# allowed storage account with FileStorage type
resource "azurerm_storage_account" "storage1" {
  name                            = "allowed${module.naming.storage_account.name_unique}"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  account_tier                    = "Premium"
  account_replication_type        = "ZRS"
  account_kind                    = "FileStorage"
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  shared_access_key_enabled       = true
  public_network_access_enabled   = false
  default_to_oauth_authentication = true
  local_user_enabled              = false
  allow_nested_items_to_be_public = false

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.workload_subnet.id]
    bypass                     = ["AzureServices"]
  }
}

# denied storage account with FileStorage type
resource "azurerm_storage_account" "storage2" {
  name                            = "denied${module.naming.storage_account.name_unique}"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  account_tier                    = "Premium"
  account_replication_type        = "ZRS"
  account_kind                    = "FileStorage"
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  shared_access_key_enabled       = true
  public_network_access_enabled   = true
  default_to_oauth_authentication = true
  local_user_enabled              = false
  allow_nested_items_to_be_public = false
  
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.workload_subnet.id]
    bypass                     = ["AzureServices"]
  }
}

# create file share in the allowed storage account
resource "azurerm_storage_share" "share1" {
  name               = "allowed-fileshare"
  storage_account_id = azurerm_storage_account.storage1.id
  quota              = 200
  access_tier        = "Premium"
}

# create file share in the denied storage account
resource "azurerm_storage_share" "share2" {
  name               = "denied-fileshare"
  storage_account_id = azurerm_storage_account.storage2.id
  quota              = 200
  access_tier        = "Premium"
} 
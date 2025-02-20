# To be used in storage_account module
module "naming" {
  source = "Azure/naming/azurerm"
  suffix = ["storageacct"]
}

resource "azurerm_user_assigned_identity" "vm" {
  location            = azurerm_resource_group.rg.location
  name                = module.naming.user_assigned_identity.name_unique
  resource_group_name = azurerm_resource_group.rg.name
}

# allowed and denied storage accounts
module "storage_account" {
  depends_on = [module.avm-res-network-virtualnetwork]
  for_each = var.storage

  source                     = "github.com/Azure/terraform-azurerm-avm-res-storage-storageaccount"
  account_replication_type   = "LRS"
  account_tier               = "Standard"
  account_kind               = "StorageV2"
  location                   = azurerm_resource_group.rg.location
  name                       = "${each.value.prefix}${module.naming.storage_account.name_unique}"
  https_traffic_only_enabled = true
  resource_group_name        = azurerm_resource_group.rg.name
  min_tls_version            = "TLS1_2"
  shared_access_key_enabled  = true
  # allow_nested_items_to_be_public = false
  public_network_access_enabled = true
  managed_identities = {
    system_assigned            = true
    user_assigned_resource_ids = [azurerm_user_assigned_identity.vm.id]
  }
  blob_properties = {
    versioning_enabled = true
  }
  role_assignments = {
    role_assignment_1 = {
      role_definition_id_or_name       = data.azurerm_role_definition.role.name
      principal_id                     = data.azurerm_client_config.current.object_id
      skip_service_principal_aad_check = false
    },
    role_assignment_2 = {
      role_definition_id_or_name       = "Owner"
      principal_id                     = data.azurerm_client_config.current.object_id
      skip_service_principal_aad_check = false
    },
  }
  network_rules = {
    bypass                     = ["AzureServices"]
    default_action             = "Deny"
    ip_rule                    = data.azurerm_subnet.BastionSubnet.address_prefix
    virtual_network_subnet_id  = data.azurerm_subnet.BastionSubnet.id
  }
  containers = {
    blob_container0 = {
      name = each.value.container_name
      # public_access = "container"
    }
  }
  shares = {
    share0 = {
      name        = each.value.file_name
      quota       = 10
      access_tier = "Hot"
    }
  }
}
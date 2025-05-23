# Create vnet 
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnet.address_space]
  dns_servers         = ["8.8.8.8", "9.9.9.9"]
}

# The policy ensures users in the subnet can only access safe and allowed Azure Storage accounts.
resource "azurerm_subnet_service_endpoint_storage_policy" "policy" {
  name                = "serviceEP_policy"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  # Policy definition for allowing storage account to the service endpoint policy
  definition {
    name        = "SEP_policy_definition"
    description = "policy to allow access to valid storage account"
    service     = "Microsoft.Storage"
    service_resources = [
      # allow access to only "storage1"
      azurerm_storage_account.storage1.id
    ]
  }
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.BastionSubnet]
}

# Create workload subnet and enable service endpoint in the subnet.
# Then associate the subnet with service endpoint policy for the allowed storage account
resource "azurerm_subnet" "workload_subnet" {
  name                 = "Workload-Subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.workload_subnet]
  service_endpoints    = ["Microsoft.Storage"]
  # service endpoint policy association 
  service_endpoint_policy_ids = [azurerm_subnet_service_endpoint_storage_policy.policy.id]
}

# wait 30s after the creation of workload subnet
resource "time_sleep" "delay_net_rule1_creation" {
  depends_on = [azurerm_subnet.workload_subnet]

  create_duration = "30s"
}

# Deny all access to storage accounts, and allow only access from selected subnet
resource "azurerm_storage_account_network_rules" "net_rule1" {
  storage_account_id         = azurerm_storage_account.storage1.id
  default_action             = "Deny"
  virtual_network_subnet_ids = [azurerm_subnet.workload_subnet.id]
  bypass                     = ["AzureServices"]

  depends_on = [time_sleep.delay_net_rule1_creation]
}

# Deny all access to storage accounts, and allow only access from selected subnet
resource "azurerm_storage_account_network_rules" "net_rule2" {
  storage_account_id         = azurerm_storage_account.storage2.id
  default_action             = "Deny"
  virtual_network_subnet_ids = [azurerm_subnet.workload_subnet.id]
  bypass                     = ["AzureServices"]

  depends_on = [time_sleep.delay_net_rule1_creation]
}

# # Keep for future use
# resource "azurerm_role_assignment" "role" {
#   for_each = toset([data.azurerm_client_config.current.object_id,
#   data.azuread_service_principal.spn.object_id])

#   scope                            = azurerm_resource_group.rg.id
#   role_definition_name             = data.azurerm_role_definition.role.name
#   principal_id                     = each.value
#   skip_service_principal_aad_check = false
# }

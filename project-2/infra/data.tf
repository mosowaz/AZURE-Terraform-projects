# We need this to get the object_id of the current user
data "azurerm_client_config" "current" {}

# We use the role definition data source to get the id of the Contributor role
data "azurerm_role_definition" "role" {
  name = "Contributor"
}

data "azurerm_subscription" "primary" {
}
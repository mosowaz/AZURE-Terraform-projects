resource "azurerm_user_assigned_identity" "VMSS" {
  location            = azurerm_resource_group.rg.location
  name                = "VMSS-idnetity"
  resource_group_name = azurerm_resource_group.rg.name
}

data "azurerm_user_assigned_identity" "VMSS" {
  name                = azurerm_user_assigned_identity.VMSS.name
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_role_assignment" "role1" {
  for_each = toset([data.azurerm_client_config.current.object_id,
  data.azuread_service_principal.spn.object_id])

  scope                            = azurerm_resource_group.rg.id
  role_definition_name             = data.azurerm_role_definition.role.name
  principal_id                     = each.value
  skip_service_principal_aad_check = false
}

resource "azurerm_role_assignment" "role2" {
  scope                            = azurerm_resource_group.rg.id
  role_definition_name             = data.azurerm_role_definition.role.name
  principal_id                     = data.azurerm_user_assigned_identity.VMSS.principal_id
  skip_service_principal_aad_check = false
}
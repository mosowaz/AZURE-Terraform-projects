terraform {
  required_version = "1.9.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  storage_use_azuread = true
  
  client_id       = data.azurerm_key_vault_secret.client_id.value
  client_secret   = data.azurerm_key_vault_secret.client_secret.value
  tenant_id       = data.azurerm_key_vault_secret.tenant_id.value
  subscription_id = data.azurerm_key_vault_secret.subscription_id.value
}

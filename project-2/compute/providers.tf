terraform {
  required_version = "= 1.9.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 4.0.1"
    }
    azapi = {
      source  = "azure/azapi"
      version = "=1.15.0"
    }
  }
}

provider "azapi" {
}

provider "azurerm" {
  features {}
  storage_use_azuread = true
}
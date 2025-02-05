terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.16.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }

    azapi = {
      source = "Azure/azapi"
      version = ">= 1.13, < 3"
    }

    modtm = {
      source  = "hashicorp/modtm"
      version = "~> 0.3"
    }   
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  resource_provider_registrations = "none"
  storage_use_azuread = true
}

provider "random" {
}

provider "modtm" {
}

provider "azapi" {
}
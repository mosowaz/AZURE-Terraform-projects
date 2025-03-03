terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.116, < 5"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }

    azapi = {
      source  = "Azure/azapi"
      version = ">= 1.13, < 3"
    }

    modtm = {
      source  = "Azure/modtm"
      version = "~> 0.3"
    }

    azuread = {
      source = "hashicorp/azuread"
      version = "3.1.0"  
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
}

provider "random" {
}

provider "modtm" {
}

provider "azapi" {
}

provider "azuread" {
}
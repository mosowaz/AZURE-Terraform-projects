terraform {

  backend "azurerm" {
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.10"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "3.1.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
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

provider "azuread" {
}

provider "time" {
}
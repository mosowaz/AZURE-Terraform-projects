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
    virtual_machine {
      detach_implicit_data_disk_on_deletion = true
      delete_os_disk_on_deletion            = true
      skip_shutdown_and_force_delete        = true
    }
    virtual_machine_scale_set {
      force_delete                  = false
      roll_instances_when_required  = true
      scale_to_zero_before_deletion = false
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
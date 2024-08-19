# **** Configure the Azure provider ****
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = "canadacentral"
  tags = {
    az-lab4 = "Restrict network access to resources"
  }
}

# **** Create a virtual network ****

resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet1_name
  address_space       = [var.vnet1_address_space]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# **** Create AzureBastionSubnet and public ip with bastion host ****

resource "azurerm_subnet" "bastion-subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.0.0/26"]
}

resource "azurerm_public_ip" "pub-ip" {
  name                = "bastion-pubic-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-host"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion-subnet.id
    public_ip_address_id = azurerm_public_ip.pub-ip.id
  }
}

# ***** Create subnet-public where vm1 with restriction to storage will be located ******

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet-public"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}
# ***** Subnet-private for service endpoint (storage) and allowed vm2 ******

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet-private"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_acct
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_subnet_service_endpoint_storage_policy" "example" {
  name                = "example-policy"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  definition {
    name        = "name1" # ********* To be modified *************
    description = "definition1" # ******* To be modified *************
    service     = "Microsoft.Storage"
    service_resources = [
      azurerm_resource_group.rg.id,
      azurerm_storage_account.storage.id
    ]
  }

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
    az-lab = var.lab_tag
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

# ***** Create subnet-public, where vm1 with restriction to storage will be located ******

resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet1_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.subnet1_address_prefix]
}
# ***** Subnet-private for service endpoint (storage) and allowed vm2 ******

resource "azurerm_subnet" "subnet2" {
  name                 = var.subnet2_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.subnet2_address_prefix]
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_network_security_group" "nsg1" {
  name                = var.nsg1
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# ***** Security rule to allow access to Storage *****

resource "azurerm_network_security_rule" "rule1" {
    name                       = var.security_rule1
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = [var.destination_ports]
    source_address_prefix      = var.source_service_tag1
    destination_address_prefix = var.destination_service_tag1
    resource_group_name         = azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.nsg1.name
}

# ***** Security rule to deny access to the Internet *****

resource "azurerm_network_security_rule" "rule2" {
    name                       = var.security_rule2
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.source_service_tag1
    destination_address_prefix = var.destination_service_tag2
    resource_group_name         = azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.nsg1.name
}

resource "azurerm_subnet_network_security_group_association" "nsg-association-1" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

# ********* Storage Account creation ********

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_acct
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    ip_rules                   = [azurerm_subnet.subnet2.address_prefixes]
    virtual_network_subnet_ids = [azurerm_subnet.subnet2.id]
  }
}

# ******* Create File share in Storage account *********

resource "azurerm_storage_share" "file-shares" {
  name                 = "File-share"
  storage_account_name = azurerm_storage_account.storage.name
  quota                = 50
}

resource "azurerm_subnet_service_endpoint_storage_policy" "policy" {
  name                = "storage-policy"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  definition {
    name        = "storage-policy"
    description = "storage policy for service endpoint"
    service     = "Microsoft.Storage"
    service_resources = [
      azurerm_resource_group.rg.id,
      azurerm_storage_account.storage.id
    ]
  }
}



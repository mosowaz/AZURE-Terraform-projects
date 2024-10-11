# **** Configure the Azure provider ****
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">=1.15.0"
    }
  }

}

provider "azapi" {
}

provider "azurerm" {
  features {}
  storage_use_azuread = true
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

# -----------------------------------------------------------------

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
  name                        = var.security_rule1
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.source_service_tag1
  destination_address_prefix  = var.destination_service_tag1
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg1.name
}

# ***** Security rule to deny access to the Internet *****

resource "azurerm_network_security_rule" "rule2" {
  name                        = var.security_rule2
  priority                    = 110
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.source_service_tag1
  destination_address_prefix  = var.destination_service_tag2
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg1.name
}

resource "azurerm_subnet_network_security_group_association" "nsg-association-1" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

# ------------------------------------------------------------------

# ********* Storage Account creation ********

resource "azapi_resource" "storage" {
  type      = "Microsoft.Storage/storageAccounts@2023-01-01"
  name      = var.storage_acct
  location  = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id

  body = jsonencode({
    properties = {
      accessTier            = "Hot"
      allowBlobPublicAccess = true
      allowedCopyScope      = "AAD"
      allowSharedKeyAccess  = false
      isHnsEnabled          = true
      isLocalUserEnabled    = true
      isNfsV3Enabled        = true
      keyPolicy = {
        keyExpirationPeriodInDays = 30
      }
      largeFileSharesState = "Enabled"
      networkAcls = {
        defaultAction = "Deny"
        ipRules = [
          {
            action = "Allow"
            value = "${var.mypublic_ip}"
          }
        ]
        virtualNetworkRules = [
          {
            action = "Allow"
            id     = azurerm_subnet.subnet2.id
            state  = "succeeded"
          }
        ]
      }

      #### Public network access from selected network/IPrules
 
      publicNetworkAccess = "Enabled"
    }
    sku = {
      name = "Standard_LRS"
    }
    kind = "StorageV2"

  })

  depends_on = [azurerm_subnet.subnet2]
}

# ******* Create a container (with access restriction) in Storage account to host local file *********

resource "azapi_resource" "blobService" {
  type = "Microsoft.Storage/storageAccounts/blobServices@2023-01-01"
  name = "default"
  parent_id = azapi_resource.storage.id
  body = jsonencode({
    properties = {
    }
  })
  depends_on = [
    azapi_resource.storage
  ]
}

resource "azapi_resource" "container" {
  type      = "Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01"
  name      = var.my_container
  parent_id = azapi_resource.blobService.id
  body = jsonencode({
    properties = {
      publicAccess = "Container"
    }
  })
  depends_on = [
    azapi_resource.blobService
  ]
}

resource "azurerm_storage_blob" "blob1" {
  name                   = var.my_file
  storage_account_name   = azapi_resource.storage.name
  storage_container_name = azapi_resource.container.name
  type                   = "Block"
  source                 = var.my_source_file

  depends_on = [
    azapi_resource.container
  ]
}

# ----------------------------------------------------------------------

# ****************     Linux Virtual Machine block 1   *****************

resource "azurerm_network_interface" "vm1-nic1" {
  name                = var.vm1_nic1
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.vm1_nic1_private_ip
  }
  depends_on = [
    azurerm_subnet.subnet1, azurerm_public_ip.pub-ip
  ]
}

resource "azurerm_linux_virtual_machine" "vm1" {
  name                            = var.vm_1
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.vm_size
  admin_username                  = "adminuser"
  admin_password                  = var.vm_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.vm1-nic1.id,
  ]

  depends_on = [
    azurerm_network_interface.vm1-nic1
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

# -----------------------------------------------------------------------

# ****************     Linux Virtual Machine block 2   *****************

resource "azurerm_network_interface" "vm2-nic1" {
  name                = var.vm2_nic1
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.vm2_nic1_private_ip
  }

  depends_on = [
    azurerm_subnet.subnet2
  ]

}

resource "azurerm_linux_virtual_machine" "vm2" {
  name                            = var.vm_2
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.vm_size
  admin_username                  = "adminuser"
  admin_password                  = var.vm_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.vm2-nic1.id
  ]

  depends_on = [
    azurerm_network_interface.vm2-nic1
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

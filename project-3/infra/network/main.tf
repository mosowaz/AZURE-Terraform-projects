resource "azurerm_resource_group" "rg" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

# Create vnet and subnet. Enable service endpoint in the subnet (AzureBastionSubnet)
module "avm-res-network-virtualnetwork" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"

  address_space       = [var.vnet.address_space]
  location            = azurerm_resource_group.rg.location
  name                = var.vnet.name
  resource_group_name = azurerm_resource_group.rg.name
  subnets = {
    "subnet1" = {
      name              = "AzureBastionSubnet"
      address_prefixes  = ["10.0.0.0/24"]
      service_endpoints = ["Microsoft.Storage"]
    }
  }
  dns_servers = {
    dns_servers = ["8.8.8.8"]
  }
}

# Create network security group and rules to restrict access for AzureBastionSubnet
module "network-security-group" {
  depends_on = [ module.avm-res-network-virtualnetwork ]

  source                = "Azure/network-security-group/azurerm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  security_group_name   = var.nsg_name
  source_address_prefix = data.azurerm_subnet.BastionSubnet.address_prefixes
  use_for_each          = true
  predefined_rules = [
    {
      name     = "SSH"
      priority = "500"
    }
  ]
  custom_rules = [
    # rule-1 ALLOWS outbound access from the AzureBastionSubnet to the public IP addresses assigned to the Azure Storage service
    {
      name                       = var.nsg_rule1
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      destination_address_prefix = "Storage"
      description                = "Allow-outbound-to-storage-EP"
    },
    # rule-2 DENIES outbound access from the AzureBastionSubnet to all (Internet) public IP addresses 
    # NOTE: rule-1 must have higher priority, to access Azure Storage public IP
    {
      name                       = var.nsg_rule2
      priority                   = 110
      direction                  = "Outbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      destination_address_prefix = "Internet"
      description                = "Deny-outbound-to-Internet"
    },
  ]
}

resource "azurerm_subnet_network_security_group_association" "nsg-BastionSubnet" {
  depends_on = [ module.avm-res-network-virtualnetwork ]

  subnet_id                 = data.azurerm_subnet.BastionSubnet.id
  network_security_group_id = module.network-security-group.network_security_group_id
}
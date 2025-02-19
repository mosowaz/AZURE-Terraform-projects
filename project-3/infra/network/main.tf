resource "azurerm_resource_group" "rg" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

# Create vnet and subnet. Enable service endpoint in the subnet (AzureBastionSubnet)
module "avm-res-network-virtualnetwork" {
  source              = "Azure/avm-res-network-virtualnetwork/azurerm"
  address_space       = [var.vnet.address_space]
  location            = azurerm_resource_group.rg.location
  name                = var.vnet.name
  resource_group_name = azurerm_resource_group.rg.name
  subnets = {
    "subnet1" = {
      name              = "AzureBastionSubnet"
      address_prefixes  = [var.BastionSubnet]
      service_endpoints = ["Microsoft.Storage"]
    }
  }
  dns_servers = {
    dns_servers = ["8.8.8.8"]
  }
  depends_on = [azurerm_resource_group.rg]
}

# Public IP for Bastion Host
resource "azurerm_public_ip" "pub_ip" {
  allocation_method   = "Static"
  location            = azurerm_resource_group.rg.location
  name                = "BastionPublicIP"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  depends_on = [azurerm_resource_group.rg]
}

# Create network security group and rules to restrict access to only AzureBastionSubnet
module "network-security-group" {
  source                = "Azure/network-security-group/azurerm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  security_group_name   = var.nsg_name
  source_address_prefix = [var.BastionSubnet]
 # use_for_each          = true
  
  ##############################################     Required AzureBastionSubnet Ingress NSG traffic rules      ###############################################
  # port=443, protocol=TCP, priority=120, source=Internet, destination=Any, access=Allow, description=AllowHttpsInbound                                       #  
  # port=443, protocol=TCP, priority=130, source=GatewayManager, destination=Any, access=Allow, description=AllowGatewayManagerInbound                        #
  # port=443, protocol=TCP, priority=140, source=AzureLoadBalancer, destination=Any, access=Allow, description=AllowAzureLoadBalancerInbound                  #
  # port=[8080,5701], protocol=Any, priority=150, source=VirtualNetwork, destination=VirtualNetwork, access=Allow, description=AllowBastionHostCommunication  #
  #############################################################################################################################################################

  ##############################################     Required AzureBastionSubnet Egress NSG traffic rules       ###############################################
  # port=[22,3389], protocol=Any, priority=100, source=Any, destination=VirtualNetwork, access=Allow, description=AllowSshRdpOutbound                         #                      #  
  # port=443, protocol=TCP, priority=110, source=Any, destination=AzureCloud, access=Allow, description=AllowAzureCloudOutbound                               #
  # port=[8080,5701], protocol=Any, priority=120, source=VirtualNetwork, destination=VirtualNetwork, access=Allow, description=AllowBastionCommunication      #
  # port=80, protocol=Any, priority=130, source=Any, destination=Internet, access=Allow, description=AllowHttpOutbound                                        #
  #############################################################################################################################################################

  custom_rules = [
    # rule-1 ALLOWS Https Inbound access to the AzureBastionSubnet
    {
      name                       = "Allow-Inbound-Https"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = 443
      destination_port_range     = "*"
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
    },
    # rule-2 ALLOWS GatewayManager Inbound access to the AzureBastionSubnet
    { 
      name                       = "Allow-Inbound-GatawayManager"
      priority                   = 130
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = 443
      destination_port_range     = "*"
      source_address_prefix      = "GatewayManager"
      destination_address_prefix = "*"
    },
    # rule-3 ALLOWS AzureLoadBalancer Inbound access to the AzureBastionSubnet
    { 
      name                       = "Allow-Inbound-AzureLoadBalancer"
      priority                   = 140
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = 443
      destination_port_range     = "*"
      source_address_prefix      = "AzureLoadBalancer"
      destination_address_prefix = "*"
    },
    # rule-4 ALLOWS Inbound BastionHostCommunication access between VirtualNetwork
    { 
      name                       = "Allow-Azure-Bastion-Host-Inbound-Communication"
      priority                   = 150
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_ranges         = [8080, 5701]
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "VirtualNetwork"
    },
    # rule-5 ALLOWS outbound SSH and RDP access from the AzureBastionSubnet to other target VMs 
    { 
      name                       = "Allow-SSH-RDP-Outbound"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_ranges         = [22, 3389]
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "VirtualNetwork"
    },
    # rule-6 ALLOWS outbound HTTPS access to AzureCloud
    { 
      name                       = "Allow-HTTPS-outbound-to-AzureCloud"
      priority                   = 110
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = 443
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "AzureCloud"
    },
    # rule-7 ALLOWS outbound BastionHostCommunication access between VirtualNetwork
    { 
      name                       = "Allow-Azure-Bastion-Host-Outbound-Communication"
      priority                   = 120
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_ranges         = [8080, 5701]
      destination_port_range     = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "*"
    },
    # rule-8 ALLOWS HTTP outbound from BastionSubnet 
    { 
      name                       = "Allow-Azure-Bastion-Host-Outbound-Communication"
      priority                   = 130
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = 80
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "Internet"
    },
    # rule-9 ALLOWS outbound access from AzureBastionSubnet and the public IP addresses assigned to the Azure Storage service
    {
      name                         = "Allow-Outbound-Storage-All"
      priority                     = 100
      direction                    = "Outbound"
      access                       = "Allow"
      protocol                     = "*"
      source_port_range            = "*"
      destination_port_range       = "*"
      source_address_prefix        = var.BastionSubnet
      destination_address_prefix = "Storage"
    },
    # rule-10 DENIES outbound access from the AzureBastionSubnet to all (Internet) public IP addresses 
    # NOTE: rule-9 must have higher priority, to access Azure Storage public IP
    {
      name                       = "Deny-Outbound-Internet-All"
      priority                   = 110
      direction                  = "Outbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = var.BastionSubnet
      destination_address_prefix = "Internet"
    },
  ]
  depends_on = [azurerm_resource_group.rg, module.avm-res-network-virtualnetwork]
}

# Associate the network security group to the AzureBastionSubnet
resource "azurerm_subnet_network_security_group_association" "nsg-BastionSubnet" {
  subnet_id                 = data.azurerm_subnet.BastionSubnet.id
  network_security_group_id = module.network-security-group.network_security_group_id

  depends_on = [module.avm-res-network-virtualnetwork, module.network-security-group]
}
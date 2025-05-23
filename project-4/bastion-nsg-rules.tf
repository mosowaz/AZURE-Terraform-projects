# NSG rules for Bastion Host

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

# rule-1 ALLOWS Https Inbound access to the AzureBastionSubnet
resource "azurerm_network_security_rule" "bastion-rule-1" {
  name                        = "Allow-Inbound-Https"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 443
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg[2].name
}

# rule-2 ALLOWS GatewayManager Inbound access to the AzureBastionSubnet
resource "azurerm_network_security_rule" "bastion-rule-2" {
  name                        = "Allow-Inbound-GatawayManager"
  priority                    = 130
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = 443
  destination_port_range      = "*"
  source_address_prefix       = "GatewayManager"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg[2].name
}

# rule-3 ALLOWS AzureLoadBalancer Inbound access to the AzureBastionSubnet
resource "azurerm_network_security_rule" "bastion-rule-3" {
  name                        = "Allow-Inbound-AzureLoadBalancer"
  priority                    = 140
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = 443
  destination_port_range      = "*"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg[2].name
}

# rule-4 ALLOWS Inbound BastionHostCommunication access between VirtualNetwork
resource "azurerm_network_security_rule" "bastion-rule-4" {
  name                        = "Allow-Azure-Bastion-Host-Inbound-Communication"
  priority                    = 150
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_ranges          = [8080, 5701]
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg[2].name
}

# Rule-5 ALLOWS outbound SSH and RDP access from the AzureBastionSubnet to other target VMs
resource "azurerm_network_security_rule" "bastion-rule-5" {
  name                        = "Allow-SSH-RDP-Outbound"
  priority                    = 120
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = [22, 3389]
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg[2].name
}

# rule-6 ALLOWS outbound HTTPS access to AzureCloud
resource "azurerm_network_security_rule" "bastion-rule-6" {
  name                        = "Allow-HTTPS-outbound-to-AzureCloud"
  priority                    = 130
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = 443
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "AzureCloud"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg[2].name
}

# rule-7 ALLOWS HTTP/HTTPS outbound from BastionSubnet 
resource "azurerm_network_security_rule" "bastion-rule-7" {
  name                        = "Allow-Azure-Bastion-Host-Outbound-Communication"
  priority                    = 150
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_ranges          = [80, 443]
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg[2].name
}

# Associate the network security group to the AzureBastionSubnet
resource "azurerm_subnet_network_security_group_association" "nsg-BastionSubnet" {
  subnet_id                 = azurerm_subnet.bastion_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg[2].id

  depends_on = [
    azurerm_network_security_rule.bastion-rule-1, azurerm_network_security_rule.bastion-rule-2,
    azurerm_network_security_rule.bastion-rule-3, azurerm_network_security_rule.bastion-rule-4,
    azurerm_network_security_rule.bastion-rule-5, azurerm_network_security_rule.bastion-rule-6,
    azurerm_network_security_rule.bastion-rule-7
  ]
}
resource "azurerm_virtual_network" "vnet" {
  name                = "${azurerm_resource_group.rg.name}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["168.63.129.16", "9.9.9.9"]
}

resource "azurerm_subnet" "backend" {
  name                 = "backendPool-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "jumpbox" {
  name                 = "jumpbox-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/27"]
}

resource "azurerm_subnet" "frontend" {
  name                 = "AGW-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Create public IP for the jumpbox
resource "azurerm_public_ip" "jumpbox_pip" {
  allocation_method   = "Static"
  name                = "${azurerm_resource_group.rg.name}-jumpbox-pip"
  sku                 = "Standard"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  zones               = [1, 2, 3]
}

# Create public IP for the frontend
resource "azurerm_public_ip" "agw_pip" {
  allocation_method   = "Static"
  name                = "${azurerm_resource_group.rg.name}-pip"
  sku                 = "Standard"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  zones               = [1, 2, 3]
}

#--------------- Nat Gateway Configuration---------------------
resource "azurerm_public_ip" "nat_gw_pip" {
  allocation_method   = "Static"
  name                = "natGW-pip"
  sku                 = "Standard"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Nat gateway resource
resource "azurerm_nat_gateway" "nat_gw" {
  name                    = "nat-gateway"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 15
  # Nat Gateways are zonal resources. Only one zone can be specified for nat gateway
}

# Associate Nat gateway with public IP
resource "azurerm_nat_gateway_public_ip_association" "association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gw.id
  public_ip_address_id = azurerm_public_ip.nat_gw_pip.id
}

# Associate Nat gateway with subnets
resource "azurerm_subnet_nat_gateway_association" "association" {
  subnet_id      = azurerm_subnet.backend.id
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}
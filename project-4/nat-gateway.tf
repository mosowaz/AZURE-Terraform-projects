# Create public IP for Nat Gateway
resource "azurerm_public_ip" "nat_gw_pip" {
  allocation_method   = var.nat_gw_pip.allocation_method
  name                = var.nat_gw_pip.name
  sku                 = var.nat_gw_pip.sku
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  zones               = var.availability_zones
}

# Nat gateway resource
resource "azurerm_nat_gateway" "nat_gw" {
  name                    = "nat-gateway"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 15
  zones                   = ["1"] # only one zone can be specified for nat gateway
}

# Associate Nat gateway with public IP
resource "azurerm_nat_gateway_public_ip_association" "IP-nat_gw_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gw.id
  public_ip_address_id = azurerm_public_ip.nat_gw_pip.id
}

# Associate Nat gateway with subnets
resource "azurerm_subnet_nat_gateway_association" "subnet_int-nat_gw_association" {
  subnet_id      = data.azurerm_subnet.int_lb_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_ext-nat_gw_association" {
  subnet_id      = data.azurerm_subnet.ext_lb_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}
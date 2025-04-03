# Create public IP for Bastion
resource "azurerm_public_ip" "bastion_pip" {
  allocation_method   = var.bastion_pip.allocation_method
  name                = var.bastion_pip.name
  sku                 = var.bastion_pip.sku
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  zones               = var.availability_zones
}

# Bastion subnet
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.bastion_host.subnet]
}

# Bastion host
resource "azurerm_bastion_host" "bastion_host" {
  name                = var.bastion_host.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.bastion_host.sku
  ip_connect_enabled  = var.bastion_host.ip_connect_enabled
  copy_paste_enabled  = var.bastion_host.copy_paste_enabled
  file_copy_enabled   = var.bastion_host.file_copy_enabled
  scale_units         = var.bastion_host.scale_units
  zones               = var.availability_zones

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}
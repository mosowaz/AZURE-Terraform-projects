# Public IP for Bastion Host
resource "azurerm_public_ip" "pub_ip" {
  allocation_method   = "Static"
  location            = azurerm_resource_group.rg.location
  name                = "BastionPublicIP"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
}

# Bastion Host
resource "azurerm_bastion_host" "Bastion" {
  name                = "BastionHost-SEP"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  copy_paste_enabled  = true
  sku                 = "Basic"
  scale_units         = 2
  ip_configuration {
    name                 = "my-ipconfig"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.pub_ip.id
  }
}
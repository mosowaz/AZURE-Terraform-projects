resource "azurerm_public_ip" "ext_lb_pip" {
  allocation_method   = var.ext_lb_pip.allocation_method
  name                = var.ext_lb_pip.name
  sku                 = var.ext_lb_pip.sku
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
# Create public IP for the external load balancer
resource "azurerm_public_ip" "ext_lb_pip" {
  allocation_method   = var.ext_lb_pip.allocation_method
  name                = var.ext_lb_pip.name
  sku                 = var.ext_lb_pip.sku
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create external LB
resource "azurerm_lb" "ext_lb" {
  name                = var.ext_lb.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.ext_lb.sku
  sku_tier            = var.ext_lb.sku_tier

  frontend_ip_configuration {
    name                          = "${var.ext_lb.name}-pip_Address"
    public_ip_address_id          = azurerm_public_ip.ext_lb_pip.id
  }
}
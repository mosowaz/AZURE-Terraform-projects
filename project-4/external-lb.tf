# Create public IP for the external load balancer
resource "azurerm_public_ip" "ext_lb_pip" {
  allocation_method   = var.ext_lb_pip.allocation_method
  name                = var.ext_lb_pip.name
  sku                 = var.ext_lb_pip.sku
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  zones               = var.availability_zones
}

# Create external LB
resource "azurerm_lb" "ext_lb" {
  name                = var.ext_lb.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.ext_lb.sku
  sku_tier            = var.ext_lb.sku_tier

  frontend_ip_configuration {
    name                 = "${var.ext_lb.name}-pip_Address"
    public_ip_address_id = azurerm_public_ip.ext_lb_pip.id
    zones                = var.availability_zones
  }
}

# external LB health probe 
resource "azurerm_lb_probe" "ext_lb_probe" {
  loadbalancer_id     = azurerm_lb.ext_lb.id
  name                = "probe-ext"
  port                = 80
  protocol            = "Tcp"
  interval_in_seconds = var.lb_probe_interval_in_seconds
}

# external LB backend address pool
resource "azurerm_lb_backend_address_pool" "ext_lb_backEnd_pool" {
  loadbalancer_id = azurerm_lb.ext_lb.id
  name            = "BackEndAddressPool-ext"
}

# external LB rule
resource "azurerm_lb_rule" "ext_lb_rule" {
  loadbalancer_id                = azurerm_lb.ext_lb.id
  name                           = "LB-Rule-ext"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${var.ext_lb.name}-pip_Address"
  disable_outbound_snat          = var.disable_outbound_snat
  probe_id                       = azurerm_lb_probe.ext_lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.ext_lb_backEnd_pool.id]
  idle_timeout_in_minutes        = 15
  enable_tcp_reset               = true
}

# external lb outbound rule
resource "azurerm_lb_outbound_rule" "ext_lb_outbound_rule" {
  name                    = "OutboundRule-ext"
  loadbalancer_id         = azurerm_lb.ext_lb.id
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ext_lb_backEnd_pool.id
  idle_timeout_in_minutes = 15
  enable_tcp_reset        = true
}
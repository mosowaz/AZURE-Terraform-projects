# Create internal LB
resource "azurerm_lb" "int_lb" {
  name                = var.int_lb.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.int_lb.sku
  sku_tier            = var.int_lb.sku_tier

  frontend_ip_configuration {
    name                          = "${var.int_lb.name}-IP"
    zones                         = var.availability_zones
    subnet_id                     = data.azurerm_subnet.int_lb_subnet.id
    private_ip_address_allocation = var.int_lb.private_ip_address_allocation
  }
}

# internal LB health probe 
resource "azurerm_lb_probe" "int_lb_probe" {
  loadbalancer_id     = azurerm_lb.int_lb.id
  name                = "probe-int"
  port                = 80
  protocol            = "Tcp"
  interval_in_seconds = var.lb_probe_interval_in_seconds
}

# internal LB backend address pool
resource "azurerm_lb_backend_address_pool" "int_lb_backEnd_pool" {
  loadbalancer_id    = azurerm_lb.int_lb.id
  name               = "BackEndAddressPool-int"
  synchronous_mode   = "Automatic"
  virtual_network_id = azurerm_virtual_network.vnet.id
}

# internal LB rule
resource "azurerm_lb_rule" "int_lb_rule" {
  loadbalancer_id                = azurerm_lb.int_lb.id
  name                           = "LB-Rule-int"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${var.int_lb.name}-IP"
  disable_outbound_snat          = var.disable_outbound_snat
  probe_id                       = azurerm_lb_probe.int_lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.int_lb_backEnd_pool.id]
  idle_timeout_in_minutes        = 15
  enable_tcp_reset               = true
}
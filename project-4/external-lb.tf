resource "azurerm_public_ip" "ext_lb_pip" {
  for_each            = var.pub-ip
  allocation_method   = each.value.ext_lb_pip.allocation_method
  name                = each.value.ext_lb_pip.name
  sku                 = each.value.ext_lb_pip.sku
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
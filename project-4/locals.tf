locals {
  autoscale-settings = {
    windows = {
      target_resource_id = azurerm_windows_virtual_machine_scale_set.windows_vmss.id
    }
    linux = {
      target_resource_id = azurerm_linux_virtual_machine_scale_set.linux_vmss.id
    }
  }
}
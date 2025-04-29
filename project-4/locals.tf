locals {
  autoscale-settings = {
    windows = {
      name               = "windows-autoscale-settings"
      target_resource_id = azurerm_windows_virtual_machine_scale_set.windows_vmss.id
    }
    linux = {
      name               = "linux-autoscale-settings"
      target_resource_id = azurerm_linux_virtual_machine_scale_set.linux_vmss.id
    }
  }
}
# VM Extension to install IIS on windows VMSS
resource "azurerm_virtual_machine_scale_set_extension" "windows_iis_install" {
  name                         = "Install-IIS"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.windows_vmss.id
  publisher                    = "Microsoft.Compute"
  type                         = "CustomScriptExtension"
  type_handler_version         = "1.10"
  auto_upgrade_minor_version   = true
  automatic_upgrade_enabled    = false

  settings = jsonencode({
    "fileUris": ["${path.root}/scripts/install_IIS.ps1"],
    "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File install_IIS.ps1"
  })

  protected_settings = <<PROTECTED_SETTINGS
    {
      "timeout": "PT30M"
    }
  PROTECTED_SETTINGS
}

# VM Extension to install NGINX on Linux VMSS
resource "azurerm_virtual_machine_scale_set_extension" "linux_nginx_install" {
  name                         = "install-NGINX"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.linux_vmss.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.1"
  auto_upgrade_minor_version   = true
  automatic_upgrade_enabled    = false

  settings = jsonencode({
    "fileUris": ["${path.root}/scripts/install_nginx.sh"],
    "commandToExecute": "bash install_nginx.sh"
  })

  protected_settings = <<PROTECTED_SETTINGS
    {
      "timeout": "PT30M"
    }
  PROTECTED_SETTINGS
}

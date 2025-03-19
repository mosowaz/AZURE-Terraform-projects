## Enter the storage account key for the allowed storage account that you recorded earlier.
## Replace the login account ($credential) with the name of the storage account you created.
## Replace the storage account name and fileshare name with the ones you created.
## 2nd script test for access deny to the "denied" storage acct
# Windows virtual machine extension 
resource "azurerm_virtual_machine_extension" "windows_custom_script" {
  depends_on = [azurerm_windows_virtual_machine.windows_vm]
  name                 = "windows-volume-mount-script"
  virtual_machine_id   = azurerm_windows_virtual_machine.windows_vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "2.0"

  settings = <<SETTINGS
  {
   "script": "${base64encode(file("${path.root}/script.ps1"))}"
  }
SETTINGS  
}
   
# Linux virtual machine extension 
resource "azurerm_virtual_machine_extension" "linux_custom_script" {
  depends_on = [azurerm_linux_virtual_machine.linux_vm]
  name                 = "linux-volume-mount-script"
  virtual_machine_id   = azurerm_linux_virtual_machine.linux_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
  {
   "script": "${base64encode(file("${path.root}/script.sh"))}"
  }
SETTINGS  
} 


  

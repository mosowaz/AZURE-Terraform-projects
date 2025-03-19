## Enter the storage account key for the allowed storage account that you recorded earlier.
## Replace the login account ($credential) with the name of the storage account you created.
## Replace the storage account name and fileshare name with the ones you created.
## 2nd script test for access deny to the "denied" storage acct
resource "azurerm_virtual_machine_extension" "windows_custom_script" {
  name                 = "windows-volume-mount-script"
  virtual_machine_id   = azurerm_windows_virtual_machine.windows_vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = jsonencode(<<SETTINGS
    commandToExecute: powershell.exe -ExecutionPolicy Unrestricted -Command
    $storageAcct1Key = ${azurerm_storage_account.storage1.primary_access_key};
    $acct1Key = ConvertTo-SecureString -String $storageAcct1Key -AsPlainText -Force;
    $acct1credential = New-Object System.Management.Automation.PSCredential -ArgumentList ('Azure\${azurerm_storage_account.storage1.name}'), $acct1Key;
    New-PSDrive -Name Z -PSProvider FileSystem -Root '\\${azurerm_storage_account.storage1.name}.file.core.windows.net\${azurerm_storage_share.share1.name}' -Credential $acct1credential;

    $storageAcct2Key = ${azurerm_storage_account.storage2.primary_access_key};
    $acct2Key = ConvertTo-SecureString -String $storageAcct2Key -AsPlainText -Force;
    $acct2credential = New-Object System.Management.Automation.PSCredential -ArgumentList ('Azure\${azurerm_storage_account.storage2.name}'), $acct2Key;
    New-PSDrive -Name Y -PSProvider FileSystem -Root '\\${azurerm_storage_account.storage2.name}.file.core.windows.net\${azurerm_storage_share.share2.name}' -Credential $acct2credential
    SETTINGS
  )
  protected_settings = <<PROTECTED_SETTINGS
    {
      "storageAccountName1": "${azurerm_storage_account.storage1.name}",
      "storageAccountKey1": "${azurerm_storage_account.storage1.primary_access_key}",
      "storageAccountName2": "${azurerm_storage_account.storage2.name}",
      "storageAccountKey2": "${azurerm_storage_account.storage2.primary_access_key}"
    }
    PROTECTED_SETTINGS
}
   

resource "azurerm_virtual_machine_extension" "linux_custom_script" {
  name                 = "linux-volume-mount-script"
  virtual_machine_id   = azurerm_linux_virtual_machine.linux_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = jsonencode(<<SETTINGS
    commandToExecute: bash -c apt-get update && apt-get install cifs-utils && \
    mount -t cifs ${azurerm_storage_account.storage1.name}.file.core.windows.net/${azurerm_storage_share.share1.name} /mnt/azure-share1 \
    -o username=${azurerm_storage_account.storage1.name},password=${azurerm_storage_account.storage1.primary_access_key},dir_mode=0750,file_mode=0750.serverino && \
    mount -t cifs ${azurerm_storage_account.storage2.name}.file.core.windows.net/${azurerm_storage_share.share2.name} /mnt/azure-share2 \
    -o username=${azurerm_storage_account.storage2.name},password=${azurerm_storage_account.storage2.primary_access_key},dir_mode=0750,file_mode=0750,serverino 
    SETTINGS
  )
  protected_settings = <<PROTECTED_SETTINGS
    {
      "storageAccountName1": "${azurerm_storage_account.storage1.name}",
      "storageAccountKey1": "${azurerm_storage_account.storage1.primary_access_key}",
      "storageAccountName2": "${azurerm_storage_account.storage2.name}",
      "storageAccountKey2": "${azurerm_storage_account.storage2.primary_access_key}"
    }
    PROTECTED_SETTINGS
} 


  

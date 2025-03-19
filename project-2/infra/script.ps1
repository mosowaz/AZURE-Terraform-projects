$storageAcct1Key = ${azurerm_storage_account.storage1.primary_access_key}
$acct1Key = ConvertTo-SecureString -String $storageAcct1Key -AsPlainText -Force
$acct1credential = New-Object System.Management.Automation.PSCredential -ArgumentList ('Azure\${azurerm_storage_account.storage1.name}'), $acct1Key
New-PSDrive -Name Z -PSProvider FileSystem -Root '\\${azurerm_storage_account.storage1.name}.file.core.windows.net\${azurerm_storage_share.share1.name}' -Credential $acct1credential

$storageAcct2Key = ${azurerm_storage_account.storage2.primary_access_key}
$acct2Key = ConvertTo-SecureString -String $storageAcct2Key -AsPlainText -Force
$acct2credential = New-Object System.Management.Automation.PSCredential -ArgumentList ('Azure\${azurerm_storage_account.storage2.name}'), $acct2Key
New-PSDrive -Name Y -PSProvider FileSystem -Root '\\${azurerm_storage_account.storage2.name}.file.core.windows.net\${azurerm_storage_share.share2.name}' -Credential $acct2credential
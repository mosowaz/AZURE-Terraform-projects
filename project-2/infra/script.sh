apt-get update && apt-get install cifs-utils

mount -t cifs ${azurerm_storage_account.storage1.name}.file.core.windows.net/${azurerm_storage_share.share1.name} /mnt/azure-share1 \
-o username=${azurerm_storage_account.storage1.name},password=${azurerm_storage_account.storage1.primary_access_key},dir_mode=0750,file_mode=0750.serverino

mount -t cifs ${azurerm_storage_account.storage2.name}.file.core.windows.net/${azurerm_storage_share.share2.name} /mnt/azure-share2 \
-o username=${azurerm_storage_account.storage2.name},password=${azurerm_storage_account.storage2.primary_access_key},dir_mode=0750,file_mode=0750,serverino
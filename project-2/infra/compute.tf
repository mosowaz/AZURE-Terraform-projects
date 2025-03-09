resource "azurerm_network_interface" "windows_nic" {
  name                = "windows-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.workload_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  name                = "Windows-Server"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = var.vm_password
  network_interface_ids = [
    azurerm_network_interface.windows_nic.id
  ]

  ## Enter the storage account key for the allowed storage account that you recorded earlier.
  ## Replace the login account ($credential) with the name of the storage account you created.
  ## Replace the storage account name and fileshare name with the ones you created.
  ## 2nd script test for access deny to the "denied" storage acct
  user_data = base64encode(<<-EOF
              $storageAcct1Key = ${azurerm_storage_account.storage1.primary_access_key}
              $acct1Key = ConvertTo-SecureString -String $storageAcct1Key -AsPlainText -Force
              
              $acct1credential = New-Object System.Management.Automation.PSCredential -ArgumentList ("Azure\${azurerm_storage_account.storage1.name}"), $acct1Key
              
              New-PSDrive -Name Z -PSProvider FileSystem -Root "\\${azurerm_storage_account.storage1.name}.file.core.windows.net\${azurerm_storage_share.share1.name}" -Credential $acct1credential

              $storageAcct2Key = ${azurerm_storage_account.storage2.primary_access_key}
              $acct2Key = ConvertTo-SecureString -String $storageAcct2Key -AsPlainText -Force
              
              $acct2credential = New-Object System.Management.Automation.PSCredential -ArgumentList ("Azure\${azurerm_storage_account.storage1.name}"), $acct2Key
              
              New-PSDrive -Name Y -PSProvider FileSystem -Root "\\${azurerm_storage_account.storage2.name}.file.core.windows.net\${azurerm_storage_share.share2.name}" -Credential $acct2credential
              EOF
  )

  encryption_at_host_enabled = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter"
    version   = "latest"
  }
}

# resource "azurerm_network_interface" "linux_nic" {
#   name                  = "linux-nic"
#   location              = azurerm_resource_group.rg1.location
#   resource_group_name   = azurerm_resource_group.rg1.name
#   ip_forwarding_enabled = true

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.workload_subnet.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_linux_virtual_machine" "linux_vm" {
#   name                = "linux-server"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
#   size                = "Standard_F2"
#   admin_username      = "adminuser"
#   disable_password_authentication = true
#   network_interface_ids = [
#     azurerm_network_interface.linux_nic.id
#   ]
    
  # user_data = base64encode(<<-EOF
  #             sudo mount -t cifs //mystorageaccount.file.core.windows.net/myshare /mnt/azure-share -o username=mystorageaccount,password=your_access_key
  #             EOF
  # )

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = var.hub-sshkey-pub
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
# }

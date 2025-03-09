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
  user_data = base64encode(<<-EOF
              $storageAcctKey1 = ${azurerm_storage_account.storage1.primary_access_key}
              $acctKey = ConvertTo-SecureString -String $storageAcctKey1 -AsPlainText -Force
              
              $credential = New-Object System.Management.Automation.PSCredential -ArgumentList ("Azure\${azurerm_storage_account.storage1.name}"), $acctKey
              
              New-PSDrive -Name Z -PSProvider FileSystem -Root "\\${azurerm_storage_account.storage1.name}.file.core.windows.net\${azurerm_storage_share.share1.name}" -Credential $credential
              EOF
  )

  boot_diagnostics {
    storage_account_uri = "https://${azurerm_storage_account.storage1.name}.file.core.windows.net"
  }

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

#   user_data = base64encode(<<-EOF
#               #!/bin/bash
#               sudo apt-get update
#               sudo apt-get install cifs-utils
#               EOF
#   )

#   boot_diagnostics {
#     storage_account_uri = azurerm_storage_account.storage1.primary_file_endpoint
#   }

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

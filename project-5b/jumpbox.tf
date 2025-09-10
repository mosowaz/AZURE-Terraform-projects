resource "azurerm_network_interface" "jumpbox_nic" {
  name                = "jumpbox-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.jumpbox.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jumpbox_pip.id
  }
}

resource "azurerm_linux_virtual_machine" "jumpbox_vm" {
  name                            = "jumpbox-vm"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.jumpbox_nic.id
  ]

  allow_extension_operations = true
  provision_vm_agent         = true
  encryption_at_host_enabled = false

  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo -e "${azurerm_public_ip.agw_pip.ip_address} www.mydomain.com"\\n >> /etc/hosts
              echo -e "${azurerm_public_ip.agw_pip.ip_address} mydomain.com"\\n >> /etc/hosts
              EOF
  )

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("${path.root}/../SSH Keys/ssh_keys.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  depends_on = [azurerm_network_interface.jumpbox_nic]
}
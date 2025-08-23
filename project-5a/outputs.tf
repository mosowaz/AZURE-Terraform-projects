output "jumpbox_pip" {
  value = azurerm_linux_virtual_machine.jumpbox_vm.public_ip_address
}


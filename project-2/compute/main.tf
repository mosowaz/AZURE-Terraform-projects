
resource "azurerm_resource_group" "rg1" {
  name = "${var.location1}-rg"
  location = var.location1
  tags = {
    resource = "${var.lab_tag}-central-rg"
  }
}

resource "azurerm_resource_group" "rg2" {
  name = "${var.location2}-rg"
  location = var.location2
  tags = {
    resource = "${var.lab_tag}-east-rg"
  }
}

resource "azurerm_network_interface" "spoke-nic" {
  for_each      = tomap({
    spoke1 = {
      name = "${data.terraform_remote_state.network.outputs.subnets.subnet2.name}-nic"
      location = azurerm_resource_group.rg2.location
      rg_name = azurerm_resource_group.rg2.name
      subnet_id = data.terraform_remote_state.network.outputs.subnets.subnet2.subnet_id
      private_ip = "172.16.1.12"
    }
    spoke2 = {
      name = "${data.terraform_remote_state.network.outputs.subnets.subnet3.name}-nic"
      location = azurerm_resource_group.rg1.location
      rg_name = azurerm_resource_group.rg1.name
      subnet_id = data.terraform_remote_state.network.outputs.subnets.subnet3.subnet_id
      private_ip = "192.168.1.13"
    }
  })
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address = each.value.private_ip
  }
}

resource "azurerm_public_ip" "pub_ip" {
  name                = "hub-pub-ip"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "hub-nic" {
  name                = "${data.terraform_remote_state.network.outputs.subnets.subnet1.name}-nic"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  ip_forwarding_enabled = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.terraform_remote_state.network.outputs.subnets.subnet1.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.1.11"
    public_ip_address_id = data.azurerm_public_ip.pub_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "spokes-vm" {
  for_each = var.spokes-vm
  name                = each.value.name
  resource_group_name = "${each.value.rg_location}-rg"
  location            = each.value.rg_location
  size                = each.value.size
  admin_username      = each.value.admin_username
  network_interface_ids = [
    data.azurerm_network_interface.spoke-nic[each.key].id
  ]
  user_data = base64encode(each.value.user_data)

  admin_ssh_key {
    username   = each.value.admin_username
    public_key = file(each.value.public_key)
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
}

resource "azurerm_linux_virtual_machine" "hub-vm" {
  name                = var.hub-vm.name
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = var.hub-vm.size
  admin_username      = var.hub-vm.admin_username
  network_interface_ids = [
    data.azurerm_network_interface.hub-nic.id
  ]
  user_data = base64encode(var.hub-vm.user_data)

  admin_ssh_key {
    username   = var.hub-vm.admin_username
    public_key = file(var.hub-vm.public_key)
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
}
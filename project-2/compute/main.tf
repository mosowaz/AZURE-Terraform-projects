resource "azurerm_resource_group" "rg1" {
  name = data.terraform_remote_state.network.outputs.rg1.name
  location = data.terraform_remote_state.network.outputs.rg1.location
}

resource "azurerm_resource_group" "rg2" {
  name = data.terraform_remote_state.network.outputs.rg2.name
  location = data.terraform_remote_state.network.outputs.rg2.location
}

resource "azurerm_network_interface" "spoke-nic" {
  for_each      = tomap({
    spoke1 = {
      name = "${data.terraform_remote_state.network.outputs.subnet2.name}-nic"
      location = azurerm_resource_group.rg2.location
      rg_name = azurerm_resource_group.rg2.name
      subnet_id = data.terraform_remote_state.network.outputs.subnet2.subnet_id
      private_ip = ["172.16.1.12"]
    }
    spoke2 = {
      name = "${data.terraform_remote_state.network.outputs.subnet3.name}-nic"
      location = azurerm_resource_group.rg1.location
      rg_name = azurerm_resource_group.rg1.name
      subnet_id = data.terraform_remote_state.network.outputs.subnet3.subnet_id
      private_ip = ["192.168.1.13"]
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

data "azurerm_public_ip" "pub_ip" {
  name                = azurerm_public_ip.pub_ip.name
  resource_group_name = azurerm_public_ip.pub_ip.resource_group_name
}

resource "azurerm_network_interface" "hub-nic" {
  name                = "${data.terraform_remote_state.network.outputs.subnet1.name}-nic"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.terraform_remote_state.network.outputs.subnet1.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.1.11"
    public_ip_address_id = data.azurerm_public_ip.pub_ip.id
  }
}
/*
resource "azurerm_linux_virtual_machine" "name" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    data.azurerm_network_interface.hub-nic.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
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
*/
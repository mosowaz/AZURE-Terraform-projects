locals {
  spokes-vm = {
    spoke1 = {
      name           = "spoke1-vm"
      size           = "Standard_B1s"
      admin_username = "adminuser"
      rg_name        = azurerm_resource_group.rg2.name
      rg_location    = azurerm_resource_group.rg2.location
      private_ip     = "172.16.1.12"
      public_key     = var.sp1-sshkey-pub
      private_key    = var.sp1-sshkey
    }
    spoke2 = {
      name           = "spoke2-vm"
      size           = "Standard_B1s"
      admin_username = "adminuser"
      rg_name        = azurerm_resource_group.rg1.name
      rg_location    = azurerm_resource_group.rg1.location
      private_ip     = "192.168.1.13"
      public_key     = var.sp2-sshkey-pub
      private_key    = var.sp2-sshkey
    }
  }
}

locals {
  hub-vm = {
    name           = "hub-vm"
    size           = "Standard_B1s"
    admin_username = "adminuser"
    private_ip     = "10.0.1.11"
    public_key     = var.hub-sshkey-pub
    private_key    = var.hub-sshkey
  }
}
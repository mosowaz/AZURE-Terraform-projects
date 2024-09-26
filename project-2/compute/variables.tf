variable "subscription_id" {
  type = string
}

variable "location1" {
  type = string
  default = "canadacentral" 
}

variable "location2" {
  type = string
  default = "canadaeast" 
}

variable "lab_tag" {
  default = "Compute"
}

variable "spokes-vm" {
  type = map(object({
    name = string
    size = string
    admin_username = string
    public_key = string
    rg_location = string
    user_data  = string
  }))
  default = {
    "spoke1" = {
       name           = "spoke1-vm"
       size           = "Standard_B1s"
       admin_username = "adminuser"
       public_key     = "~/.ssh/spoke1-vm.pub"
       rg_location    = "canadaeast"
       user_data      = "<< EOF #!/bin/bash ping -c4 hub-vm; echo $?; ping -c4 spoke2-vm; echo $? EOF"
    }
    "spoke2" = {
       name           = "spoke2-vm"
       size           = "Standard_B1s"
       admin_username = "adminuser"
       public_key     = "~/.ssh/spoke2-vm.pub"
       rg_location    = "canadacentral"
       user_data      = "<< EOF #!/bin/bash ping -c4 hub-vm; echo $?; ping -c4 spoke1-vm; echo $? EOF"
    }
  }
}

variable "hub-vm" {
  type = object({
    name = string
    size = string
    admin_username = string
    public_key = string
    user_data  = string
  })
  default = {
    name           = "hub-vm"
    size           = "Standard_B1s"
    admin_username = "adminuser"
    public_key     = "~/.ssh/hub-vm.pub"
    user_data      = "<< EOF #!/bin/bash ping -c4 spoke2-vm; echo $?; ping -c4 spoke1-vm; echo $? EOF"
  }
}
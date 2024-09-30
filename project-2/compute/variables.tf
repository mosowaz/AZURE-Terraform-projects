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
       public_key     = "~/.ssh/spoke1/id_rsa.pub"
       rg_location    = "canadaeast"
    }
    "spoke2" = {
       name           = "spoke2-vm"
       size           = "Standard_B1s"
       admin_username = "adminuser"
       public_key     = "~/.ssh/spoke2/id_rsa.pub"
       rg_location    = "canadacentral"
    }
  }
}

variable "hub-vm" {
  type = object({
    name = string
    size = string
    admin_username = string
    public_key = string
    private_key = string
    user_data  = string
  })
  default = {
    name           = "hub-vm"
    size           = "Standard_B1s"
    admin_username = "adminuser"
    public_key     = "~/.ssh/hub/id_rsa.pub"
    private_key    = "~/.ssh/hun/id_rsa" 
  }
}
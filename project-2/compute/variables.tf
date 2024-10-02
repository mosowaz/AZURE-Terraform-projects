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

variable "mypassword" {
  sensitive = true
}

variable "spokes-vm" {
  type = map(object({
    name = string
    size = string
    admin_username = string
    rg_location = string
  }))
  default = {
    "spoke1" = {
       name           = "spoke1-vm"
       size           = "Standard_B1s"
       admin_username = "adminuser"
       rg_location    = "canadaeast"
    }
    "spoke2" = {
       name           = "spoke2-vm"
       size           = "Standard_B1s"
       admin_username = "adminuser"
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
  })
  default = {
    name           = "hub-vm"
    size           = "Standard_B1s"
    admin_username = "adminuser"
    public_key     = "~/.ssh/hub/id_rsa.pub"
  }
}
variable "subscription_id" {
  type = string
}

variable "rg1" {
  type = object({
    name = string 
    location = string 
  })
  default = { name = "rg-canadacentral", location = "canadacentral" }
}

variable "rg2" {
  type = object({
    name = string 
    location = string 
  })
  default = { name = "rg-canadaeast", location = "canadaeast" }
}

variable "lab_tag" {
  default = "vnet peering"
}

variable "vnet_peering-1" { 
  type = object({
    address_space = string
    vnet_name     = string
  })
  default = {
    address_space = "10.0.0.0/16"
    vnet_name     = "vnet-1"
  }
}

variable "vnet_peering-2" { 
  type = object({
    address_space = string
    vnet_name     = string
  })
  default = {
    address_space = "172.16.0.0/16"
    vnet_name     = "vnet-2"
  }
}

variable "vnet_peering-3" { 
  type = object({
    address_space = string
    vnet_name     = string
  })
  default = {
    address_space = "192.168.0.0/16"
    vnet_name     = "vnet-3"
  }
}
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
  default = "vnet peering"
}

variable "vnet1" { 
  type = object({
    address_space = string
    vnet_name     = string
  })
  default = {
    address_space = "10.0.0.0/16"
    vnet_name     = "vnet-1"
  }
}

variable "vnet2" { 
  type = object({
    address_space = string
    vnet_name     = string
  })
  default = {
    address_space = "172.16.0.0/16"
    vnet_name     = "vnet-2"
  }
}

variable "vnet3" { 
  type = object({
    address_space = string
    vnet_name     = string
  })
  default = {
    address_space = "192.168.0.0/16"
    vnet_name     = "vnet-3"
  }
}

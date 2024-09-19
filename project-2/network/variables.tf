variable "lab_tag" {
  default = "vnet peering with nva"
}

variable "vnet_address_space" { # chaining "for_each" between resources
  type = map(object({
    name          = string
    address_space = string
    location      = string
  }))
  default = {
    vnet-1 = { name          = "vnet1", 
               address_space = "10.0.0.0/16",
               location      = "canadacentral" 
    },
    vnet-2 = { name          = "vnet2", 
               address_space = "172.16.0.0/16", 
               location      = "canadaeast"
    }
  }
}
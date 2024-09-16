variable "location" {
  type = set(string)
  default = [
    "canadacentral",
    "canadaeast",
  ]
}

variable "vnet_address_space" {    # chaining "for_each" between resources
  type = map(object({
    name          = string
    address_space = string
    location      = string
  })) 
  default = {
    vnet-1 = { # vnet for canadacentral location
      name          = "vnet1"
      address_space = "10.0.0.0/16"
      location      = "canadacentral"
    },
    vnet-2 = { # vnet for canadaeast location
      name          = "vnet2"
      address_space = "172.16.0.0/16"
      location      = "canadaeast"
    }
  }
}
variable "lab_tag" {
  default = "vnet peering with nva"
}

variable "rg_name" {
  default = "vnet-peering"
}
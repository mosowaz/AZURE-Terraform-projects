variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "vnet" {
  type = object({
    name          = string
    address_space = string
  })
}

variable "nsg_name" {
  type = string
}

variable "BastionSubnet" {
  type = string
}

variable "storage" {
  type = map(object({
    prefix     = string
    file_share = string
  }))
}
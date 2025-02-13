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

variable "nsg_rule1" {
  type = string
}

variable "nsg_rule2" {
  type = string
}
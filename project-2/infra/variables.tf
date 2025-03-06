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

variable "nsg1_name" {
  type = string
}

variable "nsg2_name" {
  type = string
}

variable "BastionSubnet" {
  type = string
}

variable "workload_subnet" {
  type = string
}

variable "vm_password" {
  type      = string
  sensitive = true
}

variable "hub-sshkey-pub" {
  type      = string
  sensitive = true
}
variable "lb-rg-name" {
  default     = "int-ext-loadBalancer"
  description = "resource group name"
  nullable = false
}

variable "lb-rg-location" {
  default     = "int-ext-loadBalancer"
  description = "resource group location"
  nullable = false
}

variable "vnet-int" {
  type = object({
    name = string
    address_space = string
  })
  default = {
    name          = "int-lb-vnet"
    address_space = "10.1.0.0/16"
  }
  description = "virtual network for internal loadbalancer backend pools"
  nullable = false
}

variable "vnet-ext" {
  type = object({
    name = string
    address_space = string
  })
  default = {
    name          = "ext-lb-vnet"
    address_space = "10.2.0.0/16"
  }
  description = "virtual network for external loadbalancer backend pools"
  nullable = false
}
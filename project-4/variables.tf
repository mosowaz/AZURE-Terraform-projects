variable "lb-rg-name" {
  default     = "int-ext-loadBalancer"
  description = "resource group name"
}

variable "lb-rg-location" {
  default     = "canadacentral"
  description = "resource group location"
}

variable "vnet-int" {
  type = object({
    name                    = string
    address_space           = string
    subnet_name             = string
    subnet_address_prefixes = string
  })
  default = {
    name                    = "int-lb-vnet"
    address_space           = "10.1.0.0/16"
    subnet_name             = "int-lb-subnet"
    subnet_address_prefixes = "10.1.0.0/24"
  }
  description = "virtual network and subnet for internal loadbalancer backend pools"
}

variable "vnet-ext" {
  type = object({
    name                    = string
    address_space           = string
    subnet_name             = string
    subnet_address_prefixes = string
  })
  default = {
    name                    = "ext-lb-vnet"
    address_space           = "10.2.0.0/16"
    subnet_name             = "ext-lb-subnet"
    subnet_address_prefixes = "10.2.0.0/24"
  }
  description = "virtual network and subnet for external loadbalancer backend pools"
}

variable "pub-ip" {
  type = map(object({
    allocation_method = string
    name              = string
    sku               = string
  }))
  default = {
    "ext_lb_pip" = {
      allocation_method = "Static"
      name              = "ext-lb-public-IP"
      sku               = "Standard"
    }
    "int_lb_pip" = {
      allocation_method = "Static"
      name              = "int-lb-public-IP"
      sku               = "Standard"
    }
    "bastion_pip" = {
      allocation_method = "Static"
      name              = "Bastion-Public-IP"
      sku               = "Standard"
    }
    "nat_gw_pip" = {
      allocation_method = "Static"
      name              = "Nat-GW-public-IP"
      sku               = "Standard"
    }
  }
}

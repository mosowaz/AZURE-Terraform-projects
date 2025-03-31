variable "lb-rg-name" {
  default     = "rg-loadBalancers"
  description = "resource group name"
}

variable "lb-rg-location" {
  default     = "canadacentral"
  description = "resource group location"
}

variable "vnet-int" {
  default = {
    name                    = "vnet-int-lb"
    address_space           = "10.1.0.0/16"
    subnet_name             = "int-lb-subnet"
    subnet_address_prefixes = "10.1.0.0/24"
  }
  description = "virtual network and subnet for internal loadbalancer backend pools"
}

variable "vnet-ext" {
  default = {
    name                    = "vnet-ext-lb"
    address_space           = "10.2.0.0/16"
    subnet_name             = "ext-lb-subnet"
    subnet_address_prefixes = "10.2.0.0/24"
  }
  description = "virtual network and subnet for external loadbalancer backend pools"
}

variable "ext_lb" {
  default = {
    name                          = "loadbalancer-ext"
    sku                           = "Standard"
    sku_tier                      = "Regional"
  }
  description = "Properties of the external load balancer. If Global balancer is required, use sku_tier = Global"
}

variable "int_lb" {
  default = {
    name                          = "loadBalancer-int"
    sku                           = "Standard"
    sku_tier                      = "Regional"
    private_ip_address_allocation = "Dynamic"
  }
  description = "Properties of the internal load balancer. If Global balancer is required, use sku_tier = Global"
}

variable "ext_lb_pip" {
  default = {
    allocation_method = "Static"
    name              = "ext-lb-public-IP"
    sku               = "Standard"
  }
  description = "External load balancer's public IP"
}

variable "int_lb_pip" {
  default = {
    allocation_method = "Static"
    name              = "int-lb-public-IP"
    sku               = "Standard"
  }
  description = "Internal load balancer's public IP"
}

variable "bastion_pip" {
  default = {
    allocation_method = "Static"
    name              = "Bastion-Public-IP"
    sku               = "Standard"
  }
  description = "Bastion host's public IP"
}

variable "nat_gw_pip" {
  default = {
    allocation_method = "Static"
    name              = "Nat-GW-public-IP"
    sku               = "Standard"
  }
  description = "Nat gateway's public IP"
}


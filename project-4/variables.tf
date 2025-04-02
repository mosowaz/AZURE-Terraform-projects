variable "lb-rg-name" {
  default     = "rg-loadBalancers"
  description = "resource group name"
}

variable "lb-rg-location" {
  default     = "canadacentral"
  description = "resource group location"
}

variable "vnet" {
  default = {
    name                        = "vnet-lb"
    address_space               = "10.0.0.0/16"
    subnet_name_int             = "int-lb-subnet"
    subnet_address_prefixes_int = "10.0.1.0/24"
    subnet_name_ext             = "ext-lb-subnet"
    subnet_address_prefixes_ext = "10.0.2.0/24"
  }
  description = "virtual network and subnet for loadbalancer backend pools"
}

variable "ext_lb" {
  default = {
    name     = "loadbalancer-ext"
    sku      = "Standard"
    sku_tier = "Regional"
  }
  description = "Properties of the external load balancer. If Global balancer is required, use sku_tier = Global"
}

variable "lb_probe_interval_in_seconds" {
  default     = "5"
  description = "(Optional) The interval, in seconds between probes to the backend endpoint for health status."
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

variable "availability_zones" {
  type        = set(string)
  default     = ["1", "2", "3"]
  description = "Availability zones to be allocated for zonal resources"
}

variable "ext_lb_pip" {
  default = {
    allocation_method = "Static"
    name              = "ext-lb-public-IP"
    sku               = "Standard"
  }
  description = "External load balancer's public IP"
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

variable "disable_outbound_snat" {
  default     = "true"
  description = "(Optional) Is snat enabled for this Load Balancer Rule?"
}

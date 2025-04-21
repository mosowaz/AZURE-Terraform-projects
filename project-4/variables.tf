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

variable "bastion_host" {
  default = {
    subnet             = "10.0.3.0/24"
    name               = "Bastion"
    sku                = "Standard"
    ip_connect_enabled = true
    copy_paste_enabled = true
    file_copy_enabled  = true
    scale_units        = 2
  }
  description = "Bastion host properties"
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

variable "nsg-1-rule-1" {
  type = map(object({
    name                       = string
    priority                   = any
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = any
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = {
    first = {
      name                       = "allowInbound-HTTP-int1"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = 80
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "10.0.1.0/24"
    }
    second = {
      name                       = "allowInbound-HTTP-int2"
      priority                   = 210
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = 443
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "10.0.1.0/24"
    }
  }
  description = "NSG rule (Allow Inbound HTTP/HTTPS) for internal load balancer subnet"
}

variable "nsg-1-rule-2" {
  default = {
    name                       = "allowInbound-SSH-RDP"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = 3389
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "10.0.1.0/24"
  }
  description = "NSG rule (Allow Inbound RDP) for internal load balancer subnet"
}

variable "nsg-2-rule-1" {
  type = map(object({
    name                       = string
    priority                   = any
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = any
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = {
    first = {
      name                       = "allowInbound-HTTP-ext1"
      priority                   = 220
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = 80
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "10.0.2.0/24"
    }
    second = {
      name                       = "allowInbound-HTTP-ext2"
      priority                   = 230
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = 443
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "10.0.2.0/24"
    }
  }
  description = "NSG rule (Allow Inbound HTTP/HTTPS) for external load balancer subnet"
}

variable "nsg-2-rule-2" {
  default = {
    name                       = "allowInbound-SSH-RDP"
    priority                   = 440
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "10.0.2.0/24"
  }
  description = "NSG rule (Allow Inbound SSH) for external load balancer subnet"
}

variable "vmss" {
  type        = any
  default     = {}
  description = "VM backend pools used behind the internal and external load balancers. Look in vmss.tfvars for values"
}

variable "vm_password" {
  type        = string
  sensitive   = true
  description = "Windows VMSS password value, passed from pipeline variable"
}

variable "sshkey-public" {
  type        = string
  sensitive   = true
  description = "Public key for Linux VMSS, passed from pipeline variable"
}

variable "autoscale-vmss" {
  type        = any
  default     = {}
  description = "AutoScale settings for VMSS"
}
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
  description = "Virtual Network for all resources"
}

variable "nsg1_name" {
  type        = string
  description = "Network security group for Bastion Subnet"
}

variable "nsg2_name" {
  type        = string
  description = "Network security group for VM Subnet"
}

variable "BastionSubnet" {
  type        = string
  description = "Bastion Subnet"
}

variable "workload_subnet" {
  type        = string
  description = "Virtual Machine Subnet"
}

variable "vm_password" {
  type        = string
  sensitive   = true
  description = "Password to login to windows VM"
}

variable "sshkey-public" {
  type        = string
  sensitive   = true
  description = "ssh public key for linux vm. Local file in the pipeline agent"
}
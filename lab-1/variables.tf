variable "rg_name" {
  default = "lab4-1"
}

variable "vnet1_name" {
  default     = "myVnet1"
  description = "Name of 1st virtual network"
}

variable "vnet1_address_space" {
  type        = string
  description = "Cidr range for the 1st Virtual Network"
  default     = "10.0.0.0/16"
}

variable "storage_acct" {
  # Environment variable for the storage account name is stored in .bashrc file as "TF_VAR_storage_acct"
  type        = string
  description = "My storage account"
}

variable "lab_tag" {
  type        = string
  default     = "Restricting access to network resources"
}

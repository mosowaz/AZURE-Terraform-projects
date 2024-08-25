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

variable "subnet1_name" {
  default     = "subnet-public"
  description = "Name of public subnet"
}

variable "subnet2_name" {
  default     = "subnet-private"
  description = "Name of private subnet"
}

variable "subnet1_address_prefix" {
  type        = string
  description = "Cidr range for the public subnet"
  default     = "10.0.1.0/24"
}

variable "subnet2_address_prefix" {
  type        = string
  description = "Cidr range for the private subnet"
  default     = "10.0.2.0/24"
}

variable "storage_acct" {
  # Environment variable for the storage account name is stored in .bashrc file as "TF_VAR_storage_acct"
  type        = string
  description = "My storage account"
  default     = "mytechlabstorageacct4"
}

variable "lab_tag" {
  type    = string
  default = "Restricting access to network resources"
}

variable "mypublic_ip" {
  type        = string
  description = "default public ip for ingress connection to Azure resources"
  sensitive   = true
}

variable "nsg1" {
  default = "nsg-storage"
}

variable "security_rule1" {
  default = "Allow-Storage-All"
}

variable "security_rule2" {
  default = "Deny-Internet-All"
}

variable "source_service_tag1" {
  type    = string
  default = "VirtualNetwork"
}

variable "destination_service_tag1" {
  type    = string
  default = "Storage"
}

variable "destination_service_tag2" {
  type    = string
  default = "Internet"
}


# TF_VAR_vm_password is saved aas env variable
variable "vm_password" {
  type = string
  sensitive = true
}

variable "my_share" {
  default = "my-share"
}

variable "my_file" {
  default = "my-main.tf"
}

variable "my_source_file" {
  type    = string
  default = "/$HOME/projects/AZURE-Terraform/project-1/main.tf"
}

variable "vm1_nic1" {
  default = "vm1-nic1"
}

variable "vm2_nic1" {
  default = "vm2-nic1"
}

variable "vm1_nic1_private_ip" {
  default = "10.0.1.11"
  type    = string
}

variable "vm2_nic1_private_ip" {
  default = "10.0.2.22"
  type    = string
}

variable "vm_1" {
  default = "ubuntu-pub"
}

variable "vm_2" {
  default = "ubuntu-priv"
}

variable "vm_size" {
  default = "Standard_B1s"
}

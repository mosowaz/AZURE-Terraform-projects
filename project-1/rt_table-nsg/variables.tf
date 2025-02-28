variable "subscription_id" {
  type = string
}

variable "location1" {
  type = string
  default = "canadacentral" 
}

variable "location2" {
  type = string
  default = "canadaeast" 
}

variable "lab_tag" {
  default = "rt_table-nsg"
}

variable "mypublic_ip" {
  type = string
}

variable "hub_ip" {
  type = string
  default = "10.0.1.11"
}

variable "rt-spoke1-2" {
  type = string
  default = "spoke1-to-spoke2"
}

variable "rt-spoke2-1" {
  type = string
  default = "spoke2-to-spoke1"
}

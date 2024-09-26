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
  default = "Compute"
}

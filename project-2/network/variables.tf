variable "location" {
  type = set(string)
  default = [
    "canadacentral",
    "canadaeast",
  ]
}

variable "vnet_address_space" {
  type = set(string) 
  default = [
    "10.0.0.0/16",
    "172.16.0.0/16",
  ]
}

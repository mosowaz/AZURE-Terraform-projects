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
}


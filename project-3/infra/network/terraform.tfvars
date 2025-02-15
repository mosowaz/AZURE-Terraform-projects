resource_group = {
  name     = "RG-ServiceEndpoint"
  location = "canadacentral"
}

vnet = {
  name          = "vnet-SEP"
  address_space = "10.0.0.0/16"
}

nsg_name = "nsg-SEP"

BastionSubnet = "10.0.0.0/24"
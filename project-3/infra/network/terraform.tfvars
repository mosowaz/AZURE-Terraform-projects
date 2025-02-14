resource_group = {
  name     = "RG-ServiceEndpoint"
  location = "canadacentral"
}

vnet = {
  name          = "vnet-SEP"
  address_space = "10.0.0.0/16"
}

nsg_name = "nsg-SEP"

nsg_rule1 = "Allow-Storage-All"

nsg_rule2 = "Deny-Internet-All"

BastionSubnet = "10.0.0.0/24"
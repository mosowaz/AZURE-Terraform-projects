resource_group = {
  name     = "RG-ServiceEndpoint"
  location = "canadacentral"
}

vnet = {
  name          = "vnet-SEP"
  address_space = "10.0.0.0/16"
}

nsg_name = "nsg-SEP"

nsg_rule1 = "Allow-Inbound-BastionSubnet"

nsg_rule2 = "Allow-Outbound-Storage-All"

nsg_rule3 = "Deny-Outbound-Internet-All"

BastionSubnet = "10.0.0.0/24"
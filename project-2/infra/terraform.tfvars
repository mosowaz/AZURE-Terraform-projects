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

storage = {
  "storage_account1" = {
    prefix     = "allowed"
    file_share = "allowed-Fileshare"
  }
  "storage_account2" = {
    prefix     = "denied"
    file_share = "denied-Fileshare"
  }
}
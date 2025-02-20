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
    prefix         = "allowed"
    container_name = "allowed-container"
    file_name      = "allowed-Fileshare"
  }
  "storage_account2" = {
    prefix         = "denied"
    container_name = "denied-container"
    file_name      = "denied-Fileshare"
  }
}
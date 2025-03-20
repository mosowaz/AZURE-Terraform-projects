resource_group = {
  name     = "RG-ServiceEndpoint"
  location = "canadacentral"
}

vnet = {
  name          = "vnet-SEP"
  address_space = "10.0.0.0/16"
}

nsg1_name = "nsg-Bastion"

nsg2_name = "nsg-Workload"

BastionSubnet = "10.0.0.0/24"

workload_subnet = "10.0.1.0/24"

sshkey-public = "~/.ssh/VMs/vm1.pub"
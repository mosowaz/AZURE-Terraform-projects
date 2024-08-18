# Restrict network access to PaaS resources with virtual network service endpoints using the Azure portal

## Tasks
- Create a virtual network with one subnet
- Add a subnet and enable a service endpoint
- Create an Azure resource and allow network access to it from only a subnet
- Deploy a virtual machine (VM) to each subnet
- Confirm access to a resource from a subnet
- Confirm access is denied to a resource from a subnet and the internet

### Reference 
https://learn.microsoft.com/en-us/azure/virtual-network/tutorial-restrict-network-access-to-resources?tabs=portal

### Prerequisites
1. azure CLI is required for terraform to interact with azure resources
   For detailed explanation to install and login with azure cli https://learn.microsoft.com/en-us/cli/azure/install-azure-cli
2. Install and configure terraform https://developer.hashicorp.com/terraform/install
   

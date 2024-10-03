## Connect Hub and Spoke virtual networks with virtual network peering using Terraform code

![diagram to lab2](https://learn.microsoft.com/en-us/azure/virtual-network/media/tutorial-connect-virtual-networks-portal/resources-diagram.png#lightbox)
## Order of code run
./network/main.tf    ---->    ./compute/main.tf    ---->    ./rt_table-nsg/main.tf \n
Or run the bash script below \\n
``` bash tf-apply.sh ```

## Description

### ./network
1. Create 2 Spoke virtual networks and 1 Hub vnet
  
2. Peer Hub virtual network with both Spoke virtual networks
   - azurerm_virtual_network_peering.peering1-2 (hub vnet to spoke1 vnet) 
   - azurerm_virtual_network_peering.peering2-1 (spoke1 vnet to hub vnet)
   - azurerm_virtual_network_peering.peering1-3 (hub vnet to spoke2 vnet) 
   - azurerm_virtual_network_peering.peering3-1 (spoke2 vnet to hub vnet)

3. Create subnets in each virtual network - (subnet1, subnet2, and subnet3) 
 




- Deploy a virtual machine (VM) into each virtual network (hub-vm, spoke1-vm, and spoke2-vm)
- Communicate between VMs


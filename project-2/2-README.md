## Connect Hub and Spoke virtual networks with virtual network peering using Terraform code

![diagram to lab2](https://learn.microsoft.com/en-us/azure/virtual-network/media/tutorial-connect-virtual-networks-portal/resources-diagram.png#lightbox)
## Order of code
./network/main.tf --> ./compute/main.tf --> ./rt_table-nsg/main.tf\

Or run the bash script below\
``` $ bash tf-apply.sh ```

## Description

### Note
the providers version are pinned to a specific version\
terraform version = 1.9.5
azurerm version = 4.0.1 

### ./network
1. Create 2 Spoke virtual networks and 1 Hub vnet
  
2. Peer Hub virtual network with both Spoke virtual networks
   - azurerm_virtual_network_peering.peering1-2 (hub vnet to spoke1 vnet) 
   - azurerm_virtual_network_peering.peering2-1 (spoke1 vnet to hub vnet)
   - azurerm_virtual_network_peering.peering1-3 (hub vnet to spoke2 vnet) 
   - azurerm_virtual_network_peering.peering3-1 (spoke2 vnet to hub vnet)

3. Create subnets in each virtual network - (vnet1-subnet, vnet2-subnet, and vnet3-subnet) 
 
### ./compute
1. Create data source block to reference network resources (in data.tf)

2. Deploy a virtual machine (VM) into each virtual network (hub-vm, spoke1-vm, and spoke2-vm)
   - Create public ip for "hub-vm" (which is a Virtual Appliance)
   - Configure the "hub-vm" to allow ip forwarding in the user_data section
   - Introduce Provisioner "local-exec" to save the public IP address on local machine as a text file  

### ./rt_table-nsg
1. Create network security group, security rules, and rule associtaion
   - "hub-inbound-public" to allow local machine to connect to public ip of "hub-vm"
   - "hub-outbound-private" to allow access from "hub-vm" to "spoke1-vm" and "spoke2-vm"
  
2. Create route tables and associations
   - route table "spoke1-2", next hop is NVA, and destination is "vnet3-subnet".\
     Then, associate the table with "vnet2-subnet"
   - route table spoke2-1", next hop is NVA, and destination is "vnet2-subnet".\
     Then, associate the table with "vnet3-subnet" 

3. Test route between both spokes VM
   - ssh into NVA (hub-vm), and reboot it for IP forwarding configuration to take effect
   - Connect to each Spoke VM, ping and tracepath command to each other to confirm next hop.
   - Next hop should show "hub-vm"

## Test result showing tracepath and next hop between each Spoke VMs 
![spoke1-to-spoke2_route](https://github.com/user-attachments/assets/7e955037-079e-4e46-a533-e7db5db4861d)      
![spoke2-to-spoke1_route](https://github.com/user-attachments/assets/647ee7a8-e422-4ef4-a7fd-43583223bce5)

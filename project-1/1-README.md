## Restrict network access to PaaS resources with virtual network service endpoints using the Azure portal

![diagram to lab1](https://learn.microsoft.com/en-us/azure/virtual-network/media/tutorial-restrict-network-access-to-resources/resources-diagram.png)
## Tasks
- Create a virtual network with one subnet
- Add a subnet and enable a service endpoint
- Create an Azure resource and allow network access to it from only a subnet
- Deploy a virtual machine (VM) to each subnet
- Confirm access to a resource from a subnet
- Confirm access is denied to a resource from a subnet and the internet





### Reference 
https://learn.microsoft.com/en-us/azure/virtual-network/tutorial-restrict-network-access-to-resources?tabs=portal

## Command to import remote resource into terraform state
i.e azapi_resource.blobService needs to be imported to terraform state file to be managed
```
 terraform import azapi_resource.blobService "/subscriptions/<YOUR_SUBSCRIPTION_ID>/resourceGroups/lab4-1/providers/Microsoft.Storage/storageAccounts/<STORAGE_ACCOUNT_NAME>/blobServices/default"
```

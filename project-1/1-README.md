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

## Dirctory Structure
```
.
├── 1-README.md
├── main.destroy.tfplan
├── main.tf
├── main.tfplan
├── outputs.tf
├── terraform_state_list.txt
├── terraform.tfstate
├── terraform.tfstate.backup
├── variables.tf
└── main2
    ├── main2.tf
    ├── main2.tfplan
    ├── outputs.tf
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    └── variables.tf
```

## Step 1 - Run plan and apply commands
``` 
terraform plan -out main.tfplan  
terraform apply main.tfplan 
```

## Step 2 - Import remote resource into terraform state
i.e azapi_resource.blobService needs to be imported to terraform state file to be managed
```
 terraform import azapi_resource.blobService "/subscriptions/<YOUR_SUBSCRIPTION_ID>/resourceGroups/lab4-1/providers/Microsoft.Storage/storageAccounts/<STORAGE_ACCOUNT_NAME>/blobServices/default"
```

## Step 3 - Repeat "step 1"

## How to mount blob container storage to Linux VM with BlobFuse2
https://learn.microsoft.com/en-us/azure/storage/blobs/blobfuse2-how-to-deploy?tabs=Ubuntu


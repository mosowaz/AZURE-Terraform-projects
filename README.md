# AZURE-Terraform-projects

This repository is created to demonstrate the implementation of Azure resources with Terraform code and automation tool with azure-pipelines.
Links to scenerios and details can be found in each sub-directory of this repository (under Contents).

### Prerequisites
1. azure CLI is required for terraform to interact with azure resources
   For detailed explanation to install and login with azure cli https://learn.microsoft.com/en-us/cli/azure/install-azure-cli
2. Install and configure terraform https://developer.hashicorp.com/terraform/install
   
## Contents

1 - [Connect virtual networks with virtual network peering](project-1/)
    [![Build Status](https://dev.azure.com/MosesOwaseye/hub%20and%20spokes%20vnet%20peering/_apis/build/status%2Fhub%20and%20spokes%20vnet%20peering?branchName=main)](https://dev.azure.com/MosesOwaseye/hub%20and%20spokes%20vnet%20peering/_build/latest?definitionId=10&branchName=main)
  
2 - [Create and associate service endpoint policies](project-2/)
    [![Build Status](https://dev.azure.com/MosesOwaseye/azure-104-terraform-projects/_apis/build/status%2Fmosowaz.AZURE-Terraform-projects?branchName=main)](https://dev.azure.com/MosesOwaseye/azure-104-terraform-projects/_build/latest?definitionId=19&branchName=main)

3 - [Restrict network access to PaaS resources with virtual network service endpoints](project-3/)

## Terraform Commands 
```
terraform init -upgrade

terraform fmt && terraform validate

terraform plan -out main.tfplan

terraform apply main.tfplan       # or terraform apply --auto-approve
```

## To verify list of resources created, and details of resources
```
terraform state list

terraform state show <resource>   # detailed list on the resource
```

## Clean up resources
```
terraform plan -destroy -out main.destroy.tfplan  

terraform apply main.destroy.tfplan       # or terraform destroy
```
 
## Other helpful commands
```
terraform -install-autocomplete   # for autocompletion
```

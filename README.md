# AZURE-Terraform-projects

This lab is created to demonstrate the implementation of Azure resources with Terraform code.
Links to lab scenerio and the details can be found in each sub-directory of this repository (under Contents).

### Prerequisites
1. azure CLI is required for terraform to interact with azure resources
   For detailed explanation to install and login with azure cli https://learn.microsoft.com/en-us/cli/azure/install-azure-cli
2. Install and configure terraform https://developer.hashicorp.com/terraform/install
   
## Contents
1 - [Restrict network access to PaaS resources with virtual network service endpoints](project-1/1-README.md)

2 - [Connect virtual networks with virtual network peering](project-2/2-README.md)

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

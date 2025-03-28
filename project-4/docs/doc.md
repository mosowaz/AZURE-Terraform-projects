[![Build Status](https://dev.azure.com/MosesOwaseye/Load%20Balancers/_apis/build/status%2FDeploy%20Resources?branchName=main)](https://dev.azure.com/MosesOwaseye/Load%20Balancers/_build/latest?definitionId=28&branchName=main)   [![Generate terraform docs](https://github.com/mosowaz/AZURE-Terraform-projects/actions/workflows/project-4-tf-docs.yml/badge.svg?branch=main)](https://github.com/mosowaz/AZURE-Terraform-projects/actions/workflows/project-4-tf-docs.yml)

## Create private/Internal and public/external load balancer with VMSS as backend pool

![diagram](https://learn.microsoft.com/en-us/azure/load-balancer/media/quickstart-load-balancer-standard-public-portal/public-load-balancer-resources.png#lightbox)

### Steps
- Create a resource group
- Create two virtual networks and subnets
- Create private and public load balancers
- Create a network security groups (NSGs)
- Create NAT gateways
- Create a bastion host
- Create 2 sets of virtual machines scale sets ( windows and Linux)
- Install IIS on Windows
- Install Nginx on Linux
- Test both load balancers
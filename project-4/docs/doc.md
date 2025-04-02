[![Build Status](https://dev.azure.com/MosesOwaseye/Load%20Balancers/_apis/build/status%2FDeploy%20Resources?branchName=main)](https://dev.azure.com/MosesOwaseye/Load%20Balancers/_build/latest?definitionId=28&branchName=main)   [![Generate terraform docs](https://github.com/mosowaz/AZURE-Terraform-projects/actions/workflows/project-4-tf-docs.yml/badge.svg?branch=main)](https://github.com/mosowaz/AZURE-Terraform-projects/actions/workflows/project-4-tf-docs.yml)

## Create private/Internal and public/external load balancer with VMSS as backend pool

<p align="center">
  <img src="https://learn.microsoft.com/en-us/azure/load-balancer/media/quickstart-load-balancer-standard-internal-portal/internal-load-balancer-resources.png#lightbox" alt="Internal Load Balancer Resources" width="400">
  <img src="https://learn.microsoft.com/en-us/azure/load-balancer/media/quickstart-load-balancer-standard-public-portal/public-load-balancer-resources.png#lightbox" alt="Public Load Balancer Resources" width="400">
</p>

### Steps
- Create a resource group
- Create a virtual network with two subnets (for each load balancers)
- Create 3 public IPs
- Create private and public load balancers
- Create network security groups (NSGs)
- Create NAT gateway
- Create a bastion host
- Create 2 sets of backend pools ( windows and Linux VMSS)
- Install IIS on Windows
- Install Nginx on Linux
- Test both load balancers
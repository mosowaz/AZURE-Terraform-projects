<!-- BEGIN_TF_DOCS -->
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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.10 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_naming"></a> [naming](#module\_naming) | git::https://github.com/Azure/terraform-azurerm-naming.git | 75d5afae4cb01f4446025e81f76af6b60c1f927b |

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.ext_lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_public_ip.ext_lb_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_virtual_network.vnet_ext](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.vnet_int](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azuread_service_principal.spn](https://registry.terraform.io/providers/hashicorp/azuread/3.1.0/docs/data-sources/service_principal) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_role_definition.role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_subnet.ext_lb_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_pip"></a> [bastion\_pip](#input\_bastion\_pip) | Bastion host's public IP | `map` | <pre>{<br/>  "allocation_method": "Static",<br/>  "name": "Bastion-Public-IP",<br/>  "sku": "Standard"<br/>}</pre> | no |
| <a name="input_ext_lb"></a> [ext\_lb](#input\_ext\_lb) | Properties of the external load balancer. If Global balancer is required, use sku\_tier = Global | `map` | <pre>{<br/>  "name": "loadbalancer-ext",<br/>  "sku": "Standard",<br/>  "sku_tier": "Regional"<br/>}</pre> | no |
| <a name="input_ext_lb_pip"></a> [ext\_lb\_pip](#input\_ext\_lb\_pip) | External load balancer's public IP | `map` | <pre>{<br/>  "allocation_method": "Static",<br/>  "name": "ext-lb-public-IP",<br/>  "sku": "Standard"<br/>}</pre> | no |
| <a name="input_int_lb"></a> [int\_lb](#input\_int\_lb) | Properties of the internal load balancer. If Global balancer is required, use sku\_tier = Global | `map` | <pre>{<br/>  "name": "loadBalancer-int",<br/>  "private_ip_address_allocation": "Dynamic",<br/>  "sku": "Standard",<br/>  "sku_tier": "Regional"<br/>}</pre> | no |
| <a name="input_int_lb_pip"></a> [int\_lb\_pip](#input\_int\_lb\_pip) | Internal load balancer's public IP | `map` | <pre>{<br/>  "allocation_method": "Static",<br/>  "name": "int-lb-public-IP",<br/>  "sku": "Standard"<br/>}</pre> | no |
| <a name="input_lb-rg-location"></a> [lb-rg-location](#input\_lb-rg-location) | resource group location | `string` | `"canadacentral"` | no |
| <a name="input_lb-rg-name"></a> [lb-rg-name](#input\_lb-rg-name) | resource group name | `string` | `"rg-loadBalancers"` | no |
| <a name="input_nat_gw_pip"></a> [nat\_gw\_pip](#input\_nat\_gw\_pip) | Nat gateway's public IP | `map` | <pre>{<br/>  "allocation_method": "Static",<br/>  "name": "Nat-GW-public-IP",<br/>  "sku": "Standard"<br/>}</pre> | no |
| <a name="input_vnet-ext"></a> [vnet-ext](#input\_vnet-ext) | virtual network and subnet for external loadbalancer backend pools | `map` | <pre>{<br/>  "address_space": "10.2.0.0/16",<br/>  "name": "vnet-ext-lb",<br/>  "subnet_address_prefixes": "10.2.0.0/24",<br/>  "subnet_name": "ext-lb-subnet"<br/>}</pre> | no |
| <a name="input_vnet-int"></a> [vnet-int](#input\_vnet-int) | virtual network and subnet for internal loadbalancer backend pools | `map` | <pre>{<br/>  "address_space": "10.1.0.0/16",<br/>  "name": "vnet-int-lb",<br/>  "subnet_address_prefixes": "10.1.0.0/24",<br/>  "subnet_name": "int-lb-subnet"<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
<!-- BEGIN_TF_DOCS -->
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

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Inputs

No inputs.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.loadBalancer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
locals {
  nsg_1_rules = {
    # NSG rule (Allow inbound HTTP) for internal load balancer subnet
    nsg_1_rule_1 = {
      name                       = var.nsg-1-rule-1.name
      priority                   = var.nsg-1-rule-1.priority
      direction                  = var.nsg-1-rule-1.direction
      access                     = var.nsg-1-rule-1.access
      protocol                   = var.nsg-1-rule-1.protocol
      source_port_range          = var.nsg-1-rule-1.source_port_range
      destination_port_range     = var.nsg-1-rule-1.destination_port_range
      source_address_prefix      = var.nsg-1-rule-1.source_address_prefix
      destination_address_prefix = var.nsg-1-rule-1.destination_address_prefix
    },
    nsg_1_rule_2 = {
      name                       = var.nsg-1-rule-2.name
      priority                   = var.nsg-1-rule-2.priority
      direction                  = var.nsg-1-rule-2.direction
      access                     = var.nsg-1-rule-2.access
      protocol                   = var.nsg-1-rule-2.protocol
      source_port_range          = var.nsg-1-rule-2.source_port_range
      destination_port_range     = var.nsg-1-rule-2.destination_port_range
      source_address_prefix      = var.nsg-1-rule-2.source_address_prefix
      destination_address_prefix = var.nsg-1-rule-2.destination_address_prefix
    }
  }
  nsg_2_rules = {
    # NSG rule (Allow inbound HTTP) for external load balancer subnet
    nsg_2_rule_1 = {
      name                       = var.nsg-2-rule-1.name
      priority                   = var.nsg-2-rule-1.priority
      direction                  = var.nsg-2-rule-1.direction
      access                     = var.nsg-2-rule-1.access
      protocol                   = var.nsg-2-rule-1.protocol
      source_port_range          = var.nsg-2-rule-1.source_port_range
      destination_port_range     = var.nsg-2-rule-1.destination_port_range
      source_address_prefix      = var.nsg-2-rule-1.source_address_prefix
      destination_address_prefix = var.nsg-2-rule-1.destination_address_prefix
    },
    nsg_2_rule_2 = {
      name                       = var.nsg-2-rule-2.name
      priority                   = var.nsg-2-rule-2.priority
      direction                  = var.nsg-2-rule-2.direction
      access                     = var.nsg-2-rule-2.access
      protocol                   = var.nsg-2-rule-2.protocol
      source_port_range          = var.nsg-2-rule-2.source_port_range
      destination_port_range     = var.nsg-2-rule-2.destination_port_range
      source_address_prefix      = var.nsg-2-rule-2.source_address_prefix
      destination_address_prefix = var.nsg-2-rule-2.destination_address_prefix
    }
  }
}
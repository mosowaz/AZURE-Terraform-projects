module "avm-res-insights-autoscalesetting" {
  for_each = local.autoscale-settings
  source   = "git::https://github.com/Azure/terraform-azurerm-avm-res-insights-autoscalesetting.git?ref=f4e7e4b"

  name                = var.autoscale-vmss.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  target_resource_id  = each.value.target_resource_id
  enabled             = var.autoscale-vmss.enabled
  enable_telemetry    = var.autoscale-vmss.enable_telemetry

  profiles = {
    profile1 = {
      name = var.autoscale-vmss.profiles.profile1.name

      capacity = {
        default = var.autoscale-vmss.profiles.profile1.capacity.default
        maximum = var.autoscale-vmss.profiles.profile1.capacity.maximum
        minimum = var.autoscale-vmss.profiles.profile1.capacity.minimum
      }

      rules = {
        rule1 = {
          metric_trigger = {
            metric_name        = var.autoscale-vmss.profiles.profile1.rules.rule1.metric_trigger.metric_name
            metric_resource_id = each.value.target_resource_id
            operator           = var.autoscale-vmss.profiles.profile1.rules.rule1.metric_trigger.operator
            statistic          = var.autoscale-vmss.profiles.profile1.rules.rule1.metric_trigger.statistic
            threshold          = var.autoscale-vmss.profiles.profile1.rules.rule1.metric_trigger.threshold
            time_aggregation   = var.autoscale-vmss.profiles.profile1.rules.rule1.metric_trigger.time_aggregation
            time_grain         = var.autoscale-vmss.profiles.profile1.rules.rule1.metric_trigger.time_grain
            time_window        = var.autoscale-vmss.profiles.profile1.rules.rule1.metric_trigger.time_window
          }
          scale_action = {
            cooldown  = var.autoscale-vmss.profiles.profile1.rules.rule1.scale_action.cooldown
            direction = var.autoscale-vmss.profiles.profile1.rules.rule1.scale_action.direction
            type      = var.autoscale-vmss.profiles.profile1.rules.rule1.scale_action.type
            value     = var.autoscale-vmss.profiles.profile1.rules.rule1.scale_action.value
          }
        }
        rule2 = {
          metric_trigger = {
            metric_name        = var.autoscale-vmss.profiles.profile1.rules.rule2.metric_trigger.metric_name
            metric_resource_id = each.value.target_resource_id
            operator           = var.autoscale-vmss.profiles.profile1.rules.rule2.metric_trigger.operator
            statistic          = var.autoscale-vmss.profiles.profile1.rules.rule2.metric_trigger.statistic
            threshold          = var.autoscale-vmss.profiles.profile1.rules.rule2.metric_trigger.threshold
            time_aggregation   = var.autoscale-vmss.profiles.profile1.rules.rule2.metric_trigger.time_aggregation
            time_grain         = var.autoscale-vmss.profiles.profile1.rules.rule2.metric_trigger.time_grain
            time_window        = var.autoscale-vmss.profiles.profile1.rules.rule2.metric_trigger.time_window
          }
          scale_action = {
            cooldown  = var.autoscale-vmss.profiles.profile1.rules.rule2.scale_action.cooldown
            direction = var.autoscale-vmss.profiles.profile1.rules.rule2.scale_action.direction
            type      = var.autoscale-vmss.profiles.profile1.rules.rule2.scale_action.type
            value     = var.autoscale-vmss.profiles.profile1.rules.rule2.scale_action.value
          }
        }
      }
    }
  }

  predictive = {
    scale_mode = var.autoscale-vmss.predictive.scale_mode
  }
}
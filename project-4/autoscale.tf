# module "avm-res-insights-autoscalesetting" {
#   source  = "git::https://github.com/Azure/avm-res-insights-autoscalesetting.git?f4e7e4b"

#   location            = azurerm_resource_group.rg.location
#   name                = "autoscale"
#   resource_group_name = azurerm_resource_group.rg.name
#   target_resource_id  = module.terraform_azurerm_avm_res_compute_virtualmachinescaleset.resource_id
#   enabled             = true
#   tags                = local.tags

#   profiles = {
#     "profile1" = {
#       name = "autoscale"
#       capacity = {
#         default = 2
#         maximum = 4
#         minimum = 2
#       }
#       rules = {
#         rule1 = {
#           metric_trigger = {
#             metric_name        = "Percentage CPU"
#             metric_resource_id = module.terraform_azurerm_avm_res_compute_virtualmachinescaleset.resource_id
#             operator           = "LessThan"
#             statistic          = "Average"
#             threshold          = 10
#             time_aggregation   = "Average"
#             time_grain         = "PT1M"
#             time_window        = "PT2M"
#           }
#           scale_action = {
#             cooldown  = "PT1M"
#             direction = "Decrease"
#             type      = "ChangeCount"
#             value     = "1"
#           }
#         }
#         rule2 = {
#           metric_trigger = {
#             metric_name        = "Percentage CPU"
#             metric_resource_id = module.terraform_azurerm_avm_res_compute_virtualmachinescaleset.resource_id
#             operator           = "GreaterThan"
#             statistic          = "Average"
#             threshold          = 90
#             time_aggregation   = "Average"
#             time_grain         = "PT1M"
#             time_window        = "PT2M"
#           }
#           scale_action = {
#             cooldown  = "PT1M"
#             direction = "Increase"
#             type      = "ChangeCount"
#             value     = "1"
#           }
#         }
#       }
#     }
#   }

#   predictive = {
#     scale_mode      = "Enabled"
#     look_ahead_time = "PT5M"
#   }
# }
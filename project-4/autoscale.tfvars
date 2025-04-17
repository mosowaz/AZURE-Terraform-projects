autoscale-vmss = {
  name             = "VMSS-Autoscale"
  enable_telemetry = false
  enabled          = true # (Optional) Specifies whether automatic scaling is enabled for the target resource. Defaults to true.

  profiles = {
    profile1 = {
      name = "autoscale"
      capacity = {
        default = 2
        maximum = 4
        minimum = 2
      }
      rules = { # (Optional) One or more (up to 10) rule blocks as defined below.
        rule1 = {
          metric_trigger = {
            metric_name      = "Percentage CPU"
            operator         = "LessThan" # (Required) Specifies the operator used to compare the metric data and threshold. Possible values are: Equals, NotEquals, GreaterThan, GreaterThanOrEqual, LessThan, LessThanOrEqual.
            statistic        = "Average"  # (Required) Specifies how the metrics from multiple instances are combined. Possible values are Average, Max, Min and Sum.
            threshold        = 10
            time_aggregation = "Average" # (Required) Specifies how the data that's collected should be combined over time. Possible values include Average, Count, Maximum, Minimum, Last and Total.
            time_grain       = "PT1M"
            time_window      = "PT2M"
          }
          scale_action = {
            cooldown  = "PT1M" # (Required) The amount of time to wait since the last scaling action before this action occurs. Must be between 1 minute and 1 week and formatted as a ISO 8601 string.
            direction = "Decrease"
            type      = "ChangeCount" # (Required) The type of action that should occur. 
            value     = "1"           # (Required) The number of instances involved in the scaling action.
          }
        }
        rule2 = {
          metric_trigger = {
            metric_name      = "Percentage CPU"
            operator         = "GreaterThan"
            statistic        = "Average"
            threshold        = 90
            time_aggregation = "Average"
            time_grain       = "PT1M"
            time_window      = "PT2M"
          }
          scale_action = {
            cooldown  = "PT1M"
            direction = "Increase"
            type      = "ChangeCount"
            value     = "1"
          }
        }
      }
    }
  }

  predictive = {
    scale_mode = "ForecastOnly"
  }
}
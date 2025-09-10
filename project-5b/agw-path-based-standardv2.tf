#----------Application Gateway resource creation provider block-----------
resource "azurerm_application_gateway" "appGW" {
  location            = azurerm_resource_group.rg.location
  name                = module.naming.application_gateway.name_unique
  resource_group_name = azurerm_resource_group.rg.name
  enable_http2        = true
  zones               = [1, 2, 3]
  #   firewall_policy_id                = var.app_gateway_waf_policy_resource_id
  #   force_firewall_policy_association = var.force_firewall_policy_association

  #----------Backend Address Pool Configuration for the application gateway -----------
  backend_address_pool {
    name = "${local.backend_address_pool_name}-default"
  }
  backend_address_pool {
    name = "${local.backend_address_pool_name}-images"
  }
  backend_address_pool {
    name = "${local.backend_address_pool_name}-videos"
  }

  #----------Backend Http Settings Configuration for the application gateway -----------
  backend_http_settings {
    cookie_based_affinity               = "Disabled"
    name                                = local.backend_http_settings_name
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 30
    probe_name                          = local.probe_name
    pick_host_name_from_backend_address = false

    connection_draining {
      enabled           = true
      drain_timeout_sec = 300
    }
  }

  #------------Frontend IP configuration --------------
  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.agw_pip.id
    # private_ip_address            = "10.0.3.13" # Either public or private IP, not both.
    # private_ip_address_allocation = "Static"
    # subnet_id                     = azurerm_subnet.frontend.id
    # private_link_configuration_name = ""  # can be connected to private endpoint
  }

  # Frontend IP Port configuration
  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  #----------Gateway configuration for the application gateway-----------
  gateway_ip_configuration {
    name      = local.gateway_ip_configuration_name
    subnet_id = azurerm_subnet.frontend.id # Dedicated subnet
  }

  #----------Http Listeners Configuration for the application gateway  -----------
  http_listener {
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    name                           = local.http_listener_name
    protocol                       = "Http"
    # ssl_certificate_name = http_listener.value.ssl_certificate_name
    # ssl_profile_name     = http_listener.value.ssl_profile_name

    # custom_error_configuration {
    #   custom_error_page_url = lookup(custom_error_configuration.value, "custom_error_page_url", null)
    #   status_code           = lookup(custom_error_configuration.value, "status_code", null)
    # }
  }

  #----------One rule with multipath Configuration for the application gateway -----------
  request_routing_rule {
    http_listener_name = local.http_listener_name
    name               = local.request_routing_rule_name
    rule_type          = "PathBasedRouting" # or Basic 
    # backend_address_pool_name  = "${local.backend_address_pool_name}-2" # applicable only if rule_type = basic
    # backend_http_settings_name = local.backend_http_settings_name       # applicable only if rule_type = basic
    priority = 10 # 1 to 20000
    # redirect_configuration_name = local.redirect_configuration_name     # applicable only if rule_type = basic
    # rewrite_rule_set_name       = request_routing_rule.value.rewrite_rule_set_name  # applicable only if rule_type = basic
    url_path_map_name = local.url_path_map_name
  }

  url_path_map {
    name                               = local.url_path_map_name
    default_backend_address_pool_name  = "${local.backend_address_pool_name}-default" # (Optional) for default routes
    default_backend_http_settings_name = local.backend_http_settings_name             # (Optional) for default routes

    path_rule {
      name                       = "images-path-rule"
      paths                      = ["/images/*"]
      backend_address_pool_name  = "${local.backend_address_pool_name}-images"
      backend_http_settings_name = local.backend_http_settings_name
    }
    path_rule {
      name                       = "videos-path-rule"
      paths                      = ["/videos/*"]
      backend_address_pool_name  = "${local.backend_address_pool_name}-videos"
      backend_http_settings_name = local.backend_http_settings_name
    }
  }

  #----------SKU and configuration for the application gateway-----------
  sku {
    name = "Standard_v2" # or WAF_v2
    tier = "Standard_v2" # or WAF_v2
    # capacity =           # optional if autoscale_configuration is set.
  }

  autoscale_configuration {
    min_capacity = 1
    max_capacity = 2
  }

  #----------Health Probes to detect backend availability -----------
  #----------Optional Configuration  -----------
  probe {
    interval                                  = 10
    name                                      = local.probe_name
    host                                      = "127.0.0.1"
    protocol                                  = "Http"
    timeout                                   = 30
    unhealthy_threshold                       = 2
    path                                      = "/"
    minimum_servers                           = 1
    port                                      = 80
    pick_host_name_from_backend_http_settings = false
  }

  # authentication_certificate {
  #     data = authentication_certificate.value.data
  #     name = authentication_certificate.value.name
  # }

}
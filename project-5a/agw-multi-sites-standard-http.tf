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
    name = "${local.backend_address_pool_name}-1"
  }
  backend_address_pool {
    name = "${local.backend_address_pool_name}-2"
  }

  #----------Backend Http Settings Configuration for the application gateway -----------
  backend_http_settings {
    cookie_based_affinity               = "Disabled"
    name                                = local.backend_http_settings_name
    port                                = 80
    protocol                            = "Http"
    path                                = "/"
    request_timeout                     = 5
    probe_name                          = local.probe_name
    pick_host_name_from_backend_address = true

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
    name                           = "${local.http_listener_name}-1"
    protocol                       = "Http"
    host_names                     = ["www.myfirstdomain.com", "myfirstdomain.com"]
  }
  http_listener {
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    name                           = "${local.http_listener_name}-2"
    protocol                       = "Http"
    # host_name                      = "www.myseconddomain.com"
    host_names = ["www.myseconddomain.com", "myseconddomain.com"]
    # ssl_certificate_name = http_listener.value.ssl_certificate_name
    # ssl_profile_name     = http_listener.value.ssl_profile_name

    # custom_error_configuration {
    #   custom_error_page_url = lookup(custom_error_configuration.value, "custom_error_page_url", null)
    #   status_code           = lookup(custom_error_configuration.value, "status_code", null)
    # }
  }

  #----------Rules Configuration for the application gateway -----------
  request_routing_rule {
    http_listener_name         = "${local.http_listener_name}-1"
    name                       = "${local.request_routing_rule_name}-1"
    rule_type                  = "Basic" # or PathBasedRouting
    backend_address_pool_name  = "${local.backend_address_pool_name}-1"
    backend_http_settings_name = local.backend_http_settings_name
    priority                   = 10 # 1 to 20000
  }
  request_routing_rule {
    http_listener_name         = "${local.http_listener_name}-2"
    name                       = "${local.request_routing_rule_name}-2"
    rule_type                  = "Basic" # or PathBasedRouting
    backend_address_pool_name  = "${local.backend_address_pool_name}-2"
    backend_http_settings_name = local.backend_http_settings_name
    priority                   = 11 # 1 to 20000
    # redirect_configuration_name = local.redirect_configuration_name
    # rewrite_rule_set_name       = request_routing_rule.value.rewrite_rule_set_name
    # url_path_map_name           = request_routing_rule.value.url_path_map_name
  }

  #----------SKU and configuration for the application gateway-----------
  sku {
    name     = "Standard_v2" # or WAF_v2
    tier     = "Standard_v2" # or WAF_v2
    capacity = null          # optional if autoscale_configuration is set.
  }

  autoscale_configuration {
    min_capacity = 1
    max_capacity = 2
  }

  #----------Health Probes to detect backend availability -----------
  #----------Optional Configuration  -----------
  probe {
    interval            = 10
    name                = local.probe_name
    path                = "/"
    protocol            = "Http"
    timeout             = 5
    unhealthy_threshold = 2
    # host                                      = probe.value.host
    minimum_servers                           = 80
    pick_host_name_from_backend_http_settings = true
    port                                      = 80
  }

  # authentication_certificate {
  #     data = authentication_certificate.value.data
  #     name = authentication_certificate.value.name
  # }

}
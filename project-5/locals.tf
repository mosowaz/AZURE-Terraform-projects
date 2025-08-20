locals {
  backend_address_pool_name      = "mydomain-beap"
  backend_http_settings_name     = "appGatewayBackendHttpSettings"
  frontend_ip_configuration_name = "Frontend-http"
  frontend_port_name             = "frontend-port-80"
  gateway_ip_configuration_name  = "gw-IPconfig"
  http_listener_name             = "agw-listener"
  request_routing_rule_name      = "agw-routing-rule"
  #   redirect_configuration_name = ""
  #   rewrite_rule_set_name = ""
  #   url_path_map_name = ""
  
}
# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_application_gateway\main.tf
# Application Gateway Module - Main
# "Arre bhai, Application Gateway hai - traffic ka traffic police!
# Private IP matlab sirf internal access - public access nahi!"
# Gateway request ko route karta hai backend pool mein - jaise ticket wala!

# Read SSL certificate
# "Dard: Certificate read karna - path galat ho toh error aayega!"
data "azurerm_resource_group" "cert" {
  for_each = var.application_gateways
  name     = each.value.resource_group_name
}

# Application Gateway with autoscaling
# "Autoscaling - traffic badhne par automatically add hoge instances!"
resource "azurerm_application_gateway" "this" {
  for_each = var.application_gateways
  
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  
  # SKU with autoscaling
  # "SKU: Standard_v2 - auto-scaling support karta hai!"
  sku {
    name     = each.value.sku_name
    tier     = each.value.sku_tier
    capacity = each.value.capacity_min
  }
  
  # Autoscale configuration
  # "Dard: Min-max capacity galat daal di toh bill badh jayega!"
  autoscale_configuration {
    min_capacity = each.value.capacity_min
    max_capacity = each.value.capacity_max
  }
  
  # Gateway IP Configuration
  # "Gateway IP - isse gateway subnet se connect hoga!"
  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = each.value.vnet_subnet_id
  }
  
  # Frontend Port (HTTPS)
  # "Frontend port 443 - standard HTTPS port!"
  frontend_port {
    name = "https-port"
    port = each.value.frontend_port
  }
  
  # Frontend IP Configuration (Private IP only)
  # "Dard: Private IP matlab sirf internal se access - public IP nahi!"
  frontend_ip_configuration {
    name                          = "private-frontend-ip"
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address
    subnet_id                     = each.value.vnet_subnet_id
  }
  
  # Backend Address Pool
  # "Backend pool - yahan web app hai!"
  dynamic "backend_address_pool" {
    for_each = each.value.backend_address_pool
    content {
      name  = "webapp-backend-pool"
      fqdns = [backend_address_pool.value]
    }
  }
  
  # Backend HTTP Settings
  # "HTTP settings - request timeout aur cookie affinity!"
  backend_http_settings {
    name                  = "https-settings"
    port                  = 443
    protocol              = "Https"
    cookie_based_affinity = "Disabled"
    request_timeout       = each.value.request_timeout
    probe_name            = "https-probe"
  }
  
  # SSL Certificate
  # "Dard: SSL certificate galat daal diya toh HTTPS kaat jayega!"
  dynamic "ssl_certificate" {
    for_each = each.value.ssl_certificate_path != "" && fileexists(each.value.ssl_certificate_path) ? [1] : []
    content {
      name     = "ssl-cert"
      data     = filebase64(each.value.ssl_certificate_path)
      password = each.value.ssl_certificate_password
    }
  }
  
  # HTTP Listener (HTTPS)
  # "Listener - request aayi toh kahan bhejna hai!"
  http_listener {
    name                           = "https-listener"
    frontend_ip_configuration_name = "private-frontend-ip"
    frontend_port_name             = "https-port"
    protocol                       = "Https"
    ssl_certificate_name           = "ssl-cert"
  }
  
  # Request Routing Rule
  # "Routing rule - listener se pool tak ka raasta!"
  request_routing_rule {
    name                       = "https-rule"
    rule_type                  = "Basic"
    http_listener_name         = "https-listener"
    backend_address_pool_name  = "webapp-backend-pool"
    backend_http_settings_name = "https-settings"
  }
  
  # Health Probe
  # "Health probe - backend healthy hai ya nahi check karta hai!"
  probe {
    name                                      = "https-probe"
    protocol                                  = "Https"
    path                                      = "/"
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    host                                      = "127.0.0.1"
    pick_host_name_from_backend_http_settings = true
  }
  
  tags = each.value.tags
}

# Homework: Add WAF (Web Application Firewall) configuration!
# "Ghar ka kaam: WAF add karo for security against attacks!"
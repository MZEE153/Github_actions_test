# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_app_service\main.tf
# Web App (App Service) Module - Main
# "Arre bhai, Web App hai - yeh actual application chalta hai!
# Java 17 + JBoss EAP 7 - yeh combo hai production-ready!"

# Create Web Apps using for_each
# "Web App ban raha hai - Java 17, JBoss EAP 7, Linux, Private access!"
# Note: Using azurerm_linux_web_app (new resource) instead of deprecated azurerm_app_service
resource "azurerm_linux_web_app" "this" {
  for_each = var.web_apps

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  service_plan_id     = each.value.app_service_plan_id
  https_only          = each.value.https_only
  
  # App Settings for Java configuration
  # "Dard: Java version galat daal diya toh app crash ho jayega!"
  app_settings = {
    "JAVA_VERSION"                       = each.value.java_version
    "JAVA_OPTS"                          = "-Xmx512m -Xms256m"
    "WEBSITE_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  # Site config for Linux + Java
  site_config {
    application_stack {
      java_version        = each.value.java_version
      java_server         = "JBOSSEAP"
      java_server_version = each.value.java_container_version
    }

    # VNet Integration - AzureRM 4.x uses virtual_network_connection_id in site_config
    # "Dard: VNet integration galat daal diya toh connectivity nahi hogi!"
    # Note: VNet integration requires Standard+ tier, not available in Free tier

    # Health check (available in Standard+)
    # Homework: Add health check path for production!
    # "Ghar ka kaam: Health check add karo for better monitoring!"

    # CORS settings
    cors {
      allowed_origins     = ["https://example.com"]
      support_credentials = false
    }
  }

  tags = each.value.tags
}

# Homework: Add custom domain and SSL certificate!
# "Ghar ka kaam: Custom domain aur SSL certificate add karo!"

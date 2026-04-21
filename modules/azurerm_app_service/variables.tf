# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_app_service\variables.tf
# Web App (App Service) Module Variables
# "Dard: Runtime stack configure karna - Java 17, Node, Python, etc!"

variable "web_apps" {
  description = "Map of Web App configurations"
  type = map(object({
    name                   = string
    resource_group_name    = string
    location               = string
    app_service_plan_id    = string
    app_service_plan_name  = string
    runtime_stack          = string
    java_version           = string
    java_container         = optional(string)
    java_container_version = optional(string)
    os_type                = string
    https_only             = bool
    vnet_integration_subnet_id = optional(string)
    tags                   = optional(map(string))
  }))
  default = {
    webapp = {
      name                   = "AzeemwebappDev"
      resource_group_name    = "Azeemwebapp_Dev_WestCentralUS_App"
      location               = "WestCentralUS"
      app_service_plan_id    = "Azeemwebapp_Dev_AppPlan"
      app_service_plan_name  = "Azeemwebapp_Dev_AppPlan"
      runtime_stack          = "JAVA"
      java_version           = "17"
      java_container         = "JBOSS|EAP:7"
      java_container_version = "7.4"
      os_type                = "Linux"
      https_only             = true
      vnet_integration_subnet_id = ""  # Will be set from subnet output
      tags                   = {}
    }
  }
}

# Variable for Application Insights
variable "application_insights_enabled" {
  description = "Enable Application Insights"
  type        = bool
  default     = true
}

variable "application_insights_name" {
  description = "Application Insights name"
  type        = string
  default     = "Azeemwebapp_Dev_AppInsights"
}
# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_app_service_plan\variables.tf
# App Service Plan Module Variables
# "Dard: Plan ka tier yaad rakhna - Free, Basic, Standard, Premium!"

variable "app_service_plans" {
  description = "Map of App Service Plan configurations"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    kind                = string
    sku_tier            = string
    sku_size            = string
    capacity            = optional(number)
    per_site_scaling    = optional(bool)
    tags                = optional(map(string))
  }))
  default = {
    app_plan = {
      name                = "Azeemwebapp_Dev_AppPlan"
      resource_group_name = "Azeemwebapp_Dev_WestCentralUS_App"
      location            = "WestCentralUS"
      kind                = "Linux"
      sku_tier            = "Premium"
      sku_size            = "V3"
      capacity            = 1
      per_site_scaling    = false
      tags                = {}
    }
  }
}
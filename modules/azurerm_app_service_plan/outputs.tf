# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_app_service_plan\outputs.tf
# App Service Plan Module Outputs
# "Outputs: Plan ki ID chahiye? Yahan se lo!"

output "app_service_plan_names" {
  description = "Map of App Service Plan names"
  value       = { for k, v in azurerm_service_plan.this : k => v.name }
}

output "app_service_plan_ids" {
  description = "Map of App Service Plan IDs"
  value       = { for k, v in azurerm_service_plan.this : k => v.id }
}

output "app_service_plan_kinds" {
  description = "Map of App Service Plan kinds"
  value       = { for k, v in azurerm_service_plan.this : k => v.os_type }
}
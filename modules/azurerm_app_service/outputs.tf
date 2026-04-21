# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_app_service\outputs.tf
# Web App (App Service) Module Outputs
# "Outputs: Web App ki ID aur URL chahiye? Yahan se lo!"

output "web_app_names" {
  description = "Map of Web App names"
  value       = { for k, v in azurerm_linux_web_app.this : k => v.name }
}

output "web_app_ids" {
  description = "Map of Web App IDs"
  value       = { for k, v in azurerm_linux_web_app.this : k => v.id }
}

output "web_app_default_hostnames" {
  description = "Map of Web App default hostnames"
  value       = { for k, v in azurerm_linux_web_app.this : k => v.default_hostname }
}

output "web_app_outbound_ip_addresses" {
  description = "Map of Web App outbound IP addresses"
  value       = { for k, v in azurerm_linux_web_app.this : k => v.outbound_ip_addresses }
}
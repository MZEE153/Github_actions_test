# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_application_gateway\outputs.tf
# Application Gateway Module Outputs
# "Outputs: Gateway ki ID aur IP chahiye? Yahan se lo!"

output "application_gateway_names" {
  description = "Map of Application Gateway names"
  value       = { for k, v in azurerm_application_gateway.this : k => v.name }
}

output "application_gateway_ids" {
  description = "Map of Application Gateway IDs"
  value       = { for k, v in azurerm_application_gateway.this : k => v.id }
}

output "application_gateway_frontend_ip_configuration" {
  description = "Map of Application Gateway frontend IP configurations"
  value       = { for k, v in azurerm_application_gateway.this : k => v.frontend_ip_configuration }
}

output "application_gateway_backend_address_pools" {
  description = "Map of Application Gateway backend address pools"
  value       = { for k, v in azurerm_application_gateway.this : k => v.backend_address_pool }
}
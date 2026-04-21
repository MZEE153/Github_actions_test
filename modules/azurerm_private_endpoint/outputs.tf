# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_private_endpoint\outputs.tf
# Private Endpoint Module Outputs
# "Outputs: Private endpoint ki ID chahiye? Yahan se lo!"

output "private_endpoint_names" {
  description = "Map of Private Endpoint names"
  value       = { for k, v in azurerm_private_endpoint.this : k => v.name }
}

output "private_endpoint_ids" {
  description = "Map of Private Endpoint IDs"
  value       = { for k, v in azurerm_private_endpoint.this : k => v.id }
}

output "private_endpoint_private_ip_addresses" {
  description = "Map of Private Endpoint private IP addresses"
  value       = { for k, v in azurerm_private_endpoint.this : k => try(v.ip_configuration.0.private_ip_address, null) }
}
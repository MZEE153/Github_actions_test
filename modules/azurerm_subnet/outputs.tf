# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_subnet\outputs.tf
# Subnet Module Outputs
# "Outputs: Subnet IDs chahiye? Yahan se lo!"

output "subnet_names" {
  description = "Map of subnet names"
  value       = { for k, v in azurerm_subnet.this : k => v.name }
}

output "subnet_ids" {
  description = "Map of subnet IDs"
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}

output "subnet_address_prefixes" {
  description = "Map of subnet address prefixes"
  value       = { for k, v in azurerm_subnet.this : k => v.address_prefixes }
}
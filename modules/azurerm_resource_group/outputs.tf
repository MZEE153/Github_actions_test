# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_resource_group\outputs.tf
# Resource Group Module Outputs
# "Outputs: Taali isse milti hai jab resource group ban jaye!"

output "resource_group_names" {
  description = "Map of resource group names"
  value       = { for k, v in azurerm_resource_group.this : k => v.name }
}

output "resource_group_ids" {
  description = "Map of resource group IDs"
  value       = { for k, v in azurerm_resource_group.this : k => v.id }
}

output "resource_group_locations" {
  description = "Map of resource group locations"
  value       = { for k, v in azurerm_resource_group.this : k => v.location }
}
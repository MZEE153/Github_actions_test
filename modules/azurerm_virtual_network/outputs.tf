# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_virtual_network\outputs.tf
# Virtual Network Module Outputs
# "Outputs: VNet ki ID chahiye? Yahan se lo!"

output "virtual_network_names" {
  description = "Map of virtual network names"
  value       = { for k, v in azurerm_virtual_network.this : k => v.name }
}

output "virtual_network_ids" {
  description = "Map of virtual network IDs"
  value       = { for k, v in azurerm_virtual_network.this : k => v.id }
}

output "virtual_network_address_spaces" {
  description = "Map of virtual network address spaces"
  value       = { for k, v in azurerm_virtual_network.this : k => v.address_space }
}
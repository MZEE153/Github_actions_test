# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_storage_account\outputs.tf
# Storage Account Module Outputs
# "Outputs: Storage ki ID aur connection string chahiye? Yahan se lo!"

output "storage_account_names" {
  description = "Map of Storage Account names"
  value       = { for k, v in azurerm_storage_account.this : k => v.name }
}

output "storage_account_ids" {
  description = "Map of Storage Account IDs"
  value       = { for k, v in azurerm_storage_account.this : k => v.id }
}

output "storage_account_primary_endpoints" {
  description = "Map of Storage Account primary endpoints"
  value       = { for k, v in azurerm_storage_account.this : k => {
    blob    = v.primary_blob_endpoint
    dfs     = v.primary_dfs_endpoint
    file    = v.primary_file_endpoint
    queue   = v.primary_queue_endpoint
    table   = v.primary_table_endpoint
    web     = v.primary_web_endpoint
  }}
}

output "storage_account_primary_connection_string" {
  description = "Map of Storage Account primary connection strings"
  value       = { for k, v in azurerm_storage_account.this : k => v.primary_connection_string }
  sensitive   = true
}
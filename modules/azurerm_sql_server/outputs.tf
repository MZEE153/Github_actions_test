# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_sql_server\outputs.tf
# SQL Server Module Outputs
# "Outputs: SQL Server ki ID chahiye? Yahan se lo!"

output "sql_server_names" {
  description = "Map of SQL Server names"
  value       = { for k, v in azurerm_mssql_server.this : k => v.name }
}

output "sql_server_ids" {
  description = "Map of SQL Server IDs"
  value       = { for k, v in azurerm_mssql_server.this : k => v.id }
}

output "sql_server_fqdn" {
  description = "Map of SQL Server FQDNs"
  value       = { for k, v in azurerm_mssql_server.this : k => v.fully_qualified_domain_name }
}
# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_sql_server\main.tf
# SQL Server Module - Main
# "Arre bhai, SQL Server hai - data ka godown!
# Version 12.0 matlab SQL Server 2019 - latest stable!"
# SQL Server manage karta hai databases - jaise database ka manager!

# Create SQL Server
# "Dard: Admin password weak ho toh security issue ho jayega!"
resource "azurerm_mssql_server" "this" {
  for_each = var.sql_servers
  
  name                         = lower(each.value.name)
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_password
  
  # Azure AD authentication (optional)
  # Homework: Enable Azure AD authentication for production!
  # "Ghar ka kaam: Azure AD auth enable karo for better security!"
  
  # Public network access - DISABLED for security
  # "Dard: Public access enable kar diya toh hackers aa jayenge!"
  public_network_access_enabled = false
  
  # Minimum TLS version
  # "TLS 1.2 minimum - purani protocols band karo!"
  minimum_tls_version = "1.2"
  
  tags = each.value.tags
}

# SQL Firewall Rule (allow Azure services)
# "Firewall rule - Azure services se connect karne do!"
resource "azurerm_mssql_firewall_rule" "this" {
  for_each = var.sql_servers
  
  name                = "AllowAzureServices"
  server_id           = azurerm_mssql_server.this[each.key].id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

# Homework: Add VNet rule for private access!
# "Ghar ka kaam: VNet rule add karo for private connectivity!"
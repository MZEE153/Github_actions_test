# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_sql_server\variables.tf
# SQL Server Module Variables
# "Dard: SQL Server ka admin password yaad rakhna - complex hona chahiye!"

variable "sql_servers" {
  description = "Map of SQL Server configurations"
  type = map(object({
    name                   = string
    resource_group_name    = string
    location               = string
    administrator_login    = string
    administrator_password = string  # TODO: Secure password daal!
    version                = string
    tags                   = optional(map(string))
  }))
  default = {
    sql_server = {
      name                   = "azeemwebapp-dev-sql"
      resource_group_name    = "Azeemwebapp_Dev_WestCentralUS_DB"
      location               = "WestCentralUS"
      administrator_login    = "sqladmin"
      administrator_password = "ChangeMe@123"  # TODO: Strong password daal!
      version                = "12.0"
      tags                   = {}
    }
  }
}
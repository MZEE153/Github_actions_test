# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_private_endpoint\variables.tf
# Private Endpoint Module Variables
# "Dard: Private endpoint - public access band karne ke liye!"

variable "private_endpoints" {
  description = "Map of Private Endpoint configurations"
  type = map(object({
    name                   = string
    resource_group_name    = string
    location               = string
    subnet_id              = string
    target_resource_id     = string
    target_resource_type   = string  # "blob", "file", "sql", etc.
    private_connection_resource_id = string
    is_manual_connection   = bool
    tags                   = optional(map(string))
  }))
  default = {
    storage_blob_endpoint = {
      name                   = "storage-blob-pe"
      resource_group_name    = "Azeemwebapp_Dev_WestCentralUS_App"
      location               = "WestCentralUS"
      subnet_id              = ""  # Will be set from subnet output
      target_resource_id     = ""  # Will be set from storage account
      target_resource_type   = "blob"
      private_connection_resource_id = ""  # Will be set from storage account
      is_manual_connection   = false
      tags                   = {}
    }
    storage_file_endpoint = {
      name                   = "storage-file-pe"
      resource_group_name    = "Azeemwebapp_Dev_WestCentralUS_App"
      location               = "WestCentralUS"
      subnet_id              = ""  # Will be set from subnet output
      target_resource_id     = ""  # Will be set from storage account
      target_resource_type   = "file"
      private_connection_resource_id = ""  # Will be set from storage account
      is_manual_connection   = false
      tags                   = {}
    }
  }
}
# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_storage_account\variables.tf
# Storage Account Module Variables
# "Dard: Storage account ka naam - lowercase aur unique hona chahiye!"

variable "storage_accounts" {
  description = "Map of Storage Account configurations"
  type = map(object({
    name                   = string
    resource_group_name    = string
    location               = string
    account_tier           = string
    account_replication_type = string
    account_kind           = string
    enable_https_traffic_only = bool
    allow_blob_public_access = bool
    tags                   = optional(map(string))
  }))
  default = {
    app_storage = {
      name                   = "devappnameenvt"
      resource_group_name    = "Azeemwebapp_Dev_WestCentralUS_App"
      location               = "WestCentralUS"
      account_tier           = "Standard"
      account_replication_type = "LRS"
      account_kind           = "StorageV2"
      enable_https_traffic_only = true
      allow_blob_public_access = false
      tags                   = {}
    }
  }
}
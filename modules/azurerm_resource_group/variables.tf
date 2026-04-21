# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_resource_group\variables.tf
# Resource Group Module Variables
# "Dard: Resource group ka naam yaad rakhna mushkil hai!"

variable "resource_groups" {
  description = "Map of resource group configurations"
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string))
  }))
  default = {
    app = {
      name     = "Azeemwebapp_Dev_WestCentralUS_App"
      location = "WestCentralUS"
      tags     = {}
    }
    db = {
      name     = "Azeemwebapp_Dev_WestCentralUS_DB"
      location = "WestCentralUS"
      tags     = {}
    }
  }
}
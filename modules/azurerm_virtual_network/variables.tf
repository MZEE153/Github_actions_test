# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_virtual_network\variables.tf
# Virtual Network Module Variables
# "Dard: VNet ka CIDR yaad rakhna - kabhi 10.0.0.0/16, kabhi 172.16.0.0/12!"

variable "virtual_networks" {
  description = "Map of virtual network configurations"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
    tags                = optional(map(string))
  }))
  default = {
    app_vnet = {
      name                = "Azeemwebapp_Dev_WestCentralUS_App_Vnet"
      resource_group_name = "Azeemwebapp_Dev_WestCentralUS_App"
      location            = "WestCentralUS"
      address_space       = ["10.0.0.0/16"]
      tags                = {}
    }
    db_vnet = {
      name                = "Azeemwebapp_Dev_WestCentralUS_DB_Vnet"
      resource_group_name = "Azeemwebapp_Dev_WestCentralUS_DB"
      location            = "WestCentralUS"
      address_space       = ["172.16.0.0/26"]
      tags                = {}
    }
  }
}
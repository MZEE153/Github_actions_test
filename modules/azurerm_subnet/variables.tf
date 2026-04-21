# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_subnet\variables.tf
# Subnet Module Variables
# "Dard: Subnet ka CIDR calculate karna - headache hai yeh!"

variable "subnets" {
  description = "Map of subnet configurations"
  type = map(object({
    name                  = string
    resource_group_name   = string
    virtual_network_name  = string
    address_prefixes      = list(string)
    service_endpoints     = optional(list(string))
    delegation            = optional(list(object({
      service_name = string
      actions      = list(string)
    })))
  }))
  default = {
    # App VNet Subnets
    webapp_subnet = {
      name                  = "Webapp_subnet"
      resource_group_name   = "Azeemwebapp_Dev_WestCentralUS_App"
      virtual_network_name  = "Azeemwebapp_Dev_WestCentralUS_App_Vnet"
      address_prefixes      = ["10.0.1.0/24"]
      service_endpoints     = []
      delegation            = []
    }
    private_endpoint_subnet = {
      name                  = "Private_endpoint_subnet"
      resource_group_name   = "Azeemwebapp_Dev_WestCentralUS_App"
      virtual_network_name  = "Azeemwebapp_Dev_WestCentralUS_App_Vnet"
      address_prefixes      = ["10.0.2.0/24"]
      service_endpoints     = []
      delegation            = []
    }
    app_gw_subnet = {
      name                  = "App_GW_Subnet"
      resource_group_name   = "Azeemwebapp_Dev_WestCentralUS_App"
      virtual_network_name  = "Azeemwebapp_Dev_WestCentralUS_App_Vnet"
      address_prefixes      = ["10.0.3.0/24"]
      service_endpoints     = []
      delegation            = []
    }
    # DB VNet Subnet
    db_subnet = {
      name                  = "DB_Subnet"
      resource_group_name   = "Azeemwebapp_Dev_WestCentralUS_DB"
      virtual_network_name  = "Azeemwebapp_Dev_WestCentralUS_DB_Vnet"
      address_prefixes      = ["172.16.0.0/26"]
      service_endpoints     = ["Microsoft.Sql"]
      delegation            = []
    }
  }
}
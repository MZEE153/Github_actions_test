# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_application_gateway\variables.tf
# Application Gateway Module Variables
# "Dard: Gateway ka configuration - bahut saare settings!"

variable "application_gateways" {
  description = "Map of Application Gateway configurations"
  type = map(object({
    name                   = string
    resource_group_name    = string
    location               = string
    sku_name               = string
    sku_tier               = string
    capacity_min           = number
    capacity_max           = number
    vnet_subnet_id         = string
    backend_address_pool   = list(string)
    frontend_port          = number
    ssl_certificate_path   = string
    ssl_certificate_password = string
    request_timeout        = number
    tags                   = optional(map(string))
  }))
  default = {
    app_gw = {
      name                   = "App_Gw01"
      resource_group_name    = "Azeemwebapp_Dev_WestCentralUS_App"
      location               = "WestCentralUS"
      sku_name               = "Standard_v2"
      sku_tier               = "Standard_v2"
      capacity_min           = 1
      capacity_max           = 1
      vnet_subnet_id         = ""  # Will be set from subnet output
      backend_address_pool   = []  # Will be set from web app
      frontend_port          = 443
      ssl_certificate_path   = "C:/path/to/certificate.pfx"  # TODO: Certificate path daal!
      ssl_certificate_password = "your-cert-password"  # TODO: Password daal!
      request_timeout        = 30
      tags                   = {}
    }
  }
}

# Variable for private IP configuration
variable "private_ip_address" {
  description = "Private IP address for Application Gateway"
  type        = string
  default     = "10.0.3.254"  # Last IP in the subnet
}
# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_subnet\main.tf
# Subnet Module - Main
# "Arre bhai, subnet hai yeh - VNet ka chunks! Jaise building ke floors!"
# Har subnet ek IP range hai - isme resources rehte hain!

# Create subnets using for_each
# "for_each se 4 subnets bana diye - WebApp, Private Endpoint, App Gateway, DB!"
resource "azurerm_subnet" "this" {
  for_each = var.subnets
  
  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
  
  # Service endpoints for connectivity to Azure services
  # "Dard: Service endpoints galat daal diye toh connectivity nahi hogi!"
  # Note: In AzureRM 4.x, service_endpoints is a simple list
  service_endpoints = each.value.service_endpoints
  
  # Delegation for special services (like App Service, SQL, etc.)
  # "Ghar ka kaam: Delegation add karo for App Service integration!"
  dynamic "delegation" {
    for_each = each.value.delegation
    content {
      name = delegation.value.service_name
      service_delegation {
        name    = delegation.value.service_name
        actions = delegation.value.actions
      }
    }
  }
}

# Homework: Add subnet NSG rules!
# "Ghar ka kaam: NSG (Network Security Group) rules add karo for security!"
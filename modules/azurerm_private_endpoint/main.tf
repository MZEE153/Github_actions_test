# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_private_endpoint\main.tf
# Private Endpoint Module - Main
# "Arre bhai, Private Endpoint hai - public internet se private connection!
# Jaise ghar ka internal room - bahar se access nahi!"
# Private endpoint se Azure service direct VNet se connect hoti hai

# Create Private Endpoints
# "Dard: Subnet galat daal diya toh deployment fail ho jayega!"
resource "azurerm_private_endpoint" "this" {
  for_each = var.private_endpoints
  
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  subnet_id           = each.value.subnet_id
  
  # Private Connection Resource
  # "Connection - storage account se private link!"
  private_service_connection {
    name                              = "${each.value.name}-connection"
    private_connection_resource_id   = each.value.private_connection_resource_id
    is_manual_connection             = each.value.is_manual_connection
    
    # Sub-resource based on target type
    # "Dard: Sub-resource type galat daal diya toh connection nahi banega!"
    subresource_names = [each.value.target_resource_type]
  }
  
  # DNS Zone Group (for private DNS resolution)
  # "DNS Zone - isse private IP se access hoga!"
  # Note: Requires private DNS zone to be created separately
  # Homework: Add private DNS zone integration!
  # "Ghar ka kaam: Private DNS zone add karo for proper name resolution!"

  tags = each.value.tags
}

# Homework: Create Private DNS zones for each service type!
# "Ghar ka kaam: Blob, File, SQL ke liye alag-alag DNS zones banao!"
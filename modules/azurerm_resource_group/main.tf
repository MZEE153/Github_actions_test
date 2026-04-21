# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_resource_group\main.tf
# Resource Group Module - Main
# "Arre bhai, yeh resource group hai - Azure ka sabse basic building block!"
# Resource groups containers hote hain - jaise almirah ke drawers!

# Create resource groups using for_each
# "for_each se multiple resource groups bana sakte hain - ek hi code se!"
resource "azurerm_resource_group" "this" {
  for_each = var.resource_groups
  
  name     = each.value.name
  location = each.value.location
  tags     = each.value.tags
  
  # "Dard: Kabhi kabhi tags bhul jate hain - yahan rakha hai!"
}

# Homework: Add lifecycle rules for better management!
# "Ghar ka kaam: Lifecycle rules add karo for better resource management!"
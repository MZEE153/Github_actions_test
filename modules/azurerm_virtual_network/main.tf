# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_virtual_network\main.tf
# Virtual Network Module - Main
# "Arre bhai, VNet hai yeh - Azure ka internal highway system!"
# VNet se hi sab resources apas mein baat karte hain - jaise internal phone line!

# Create virtual networks using for_each
# "for_each se do VNet bana diye - ek app ke liye, ek DB ke liye!"
resource "azurerm_virtual_network" "this" {
  for_each = var.virtual_networks
  
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  address_space       = each.value.address_space
  tags                = each.value.tags
  
  # "Dard: DNS servers bhul gaya toh kaat loge!"
  # Homework: Add custom DNS servers if needed!
  # "Ghar ka kaam: Custom DNS servers add karo agar required ho!"
}

# Homework: Add DDoS Protection and Service Endpoints!
# "Ghar ka kaam: DDoS protection aur service endpoints add karo!"
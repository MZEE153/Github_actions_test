# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_app_service_plan\main.tf
# App Service Plan Module - Main
# "Arre bhai, App Service Plan hai - jaise hotel ka room! 
# Free tier (F1) matlab dormitory bed - ek free, doosre ke liye bhookh!"
# App Service Plan define karta hai kitne resources milenge - CPU, RAM, etc.

# Create App Service Plan
# "Free tier F1 - ek instance, limited resources - par free hai toh kya karega!"
# Note: Using azurerm_service_plan (new resource) instead of deprecated azurerm_app_service_plan
resource "azurerm_service_plan" "this" {
  for_each = var.app_service_plans
  
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  os_type             = each.value.kind
  
  # SKU configuration (AzureRM 4.x format)
  # "Dard: SKU galat daal diya toh plan nahi banega!"
  sku_name    = each.value.sku_size
  worker_count = each.value.capacity
  
  # Per-site scaling (available in Standard and above)
  # Homework: Enable per_site_scaling for production!
  # "Ghar ka kaam: Production ke liye per_site_scaling enable karo!"

  tags = each.value.tags
}

# Homework: Add auto-scaling settings for higher tiers!
# "Ghar ka kaam: Auto-scaling add karo for Premium tier!"


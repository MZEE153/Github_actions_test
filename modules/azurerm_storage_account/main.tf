# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\modules\azurerm_storage_account\main.tf
# Storage Account Module - Main
# "Arre bhai, Storage Account hai - files aur blobs ka storage!
# LRS = Local Redundant Storage - sabse sasta option!"
# Storage account se hum files, blobs, tables, queues store karte hain

# Create Storage Account
# "Dard: Name unique hona chahiye - agar pehle se exist karega toh error aayega!"
resource "azurerm_storage_account" "this" {
  for_each = var.storage_accounts
  
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  account_kind             = each.value.account_kind
  
  # Security settings
  # "HTTPS only - data transfer safe rahega!"
  # Note: In AzureRM 4.x, this attribute is now `https_traffic_only_enabled`
  https_traffic_only_enabled = each.value.enable_https_traffic_only
  
  # "Dard: Public access disable karo - security ke liye better hai!"
  # Note: In AzureRM 4.x, this is now `public_network_access_enabled` (inverted logic)
  public_network_access_enabled = !each.value.allow_blob_public_access
  
  # TLS version
  # "TLS 1.2 minimum - purani protocols band karo!"
  # Note: In AzureRM 4.x, valid values are TLS1_0, TLS1_1, TLS1_2, TLS1_3
  min_tls_version = "TLS1_2"
  
  # Tags
  tags = each.value.tags
}

# Enable Blob service
# "Blob service - unstructured data ke liye!"
# Note: In AzureRM 4.x, use storage_account_id instead of storage_account_name
resource "azurerm_storage_container" "this" {
  for_each = var.storage_accounts
  
  name                  = "data"
  storage_account_id    = azurerm_storage_account.this[each.key].id
  container_access_type = "private"
}

# Homework: Add file share and queue storage!
# "Ghar ka kaam: File share aur queue storage add karo if needed!"
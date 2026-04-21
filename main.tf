# filepath: C:\Users\Lenovo\Downloads\Devops\TerraformviaAgent\main.tf
# =============================================================================
# TERRAFORM ROOT MODULE - Azeemwebapp Dev Environment
# =============================================================================
# "Arre bhai, yeh root module hai - sab modules yahan se call hote hain!"
# 
# Execution Order (Zaroori hai!):
# 1. Resource Groups (sabse pehle - koi dependency nahi)
# 2. Networking (RG par depend karta hai)
# 3. Platform Services (Networking par depend karte hain)
# 4. Application Resources (sab kuch par depend karte hain)
#
# "Dard: Order galat daal diya toh deployment fail ho jayega!"
# =============================================================================

# =============================================================================
# 1. RESOURCE GROUPS (Sabse pehle!)
# "Resource groups - containers jisme sab kuch rahega!"
# =============================================================================
module "resource_groups" {
  source = "./modules/azurerm_resource_group"

  # Resource groups configuration
  # "App aur DB ke liye alag-alag resource groups!"
  resource_groups = {
    app = {
      name     = "Azeemwebapp_Dev_WestCentralUS_App"
      location = "WestCentralUS"
      tags = {
        Environment = "Dev"
        Project     = "Azeemwebapp"
      }
    }
    db = {
      name     = "Azeemwebapp_Dev_WestCentralUS_DB"
      location = "WestCentralUS"
      tags = {
        Environment = "Dev"
        Project     = "Azeemwebapp"
      }
    }
  }
}

# =============================================================================
# 2. VIRTUAL NETWORKS (Resource Groups par depend!)
# "VNet - internal network jo sab resources ko connect karta hai!"
# =============================================================================
module "app_virtual_network" {
  source = "./modules/azurerm_virtual_network"

  # App VNet configuration
  virtual_networks = {
    app_vnet = {
      name                = "Azeemwebapp_Dev_WestCentralUS_App_Vnet"
      resource_group_name = module.resource_groups.resource_group_names["app"]
      location            = "WestCentralUS"
      address_space       = ["10.0.0.0/16"]
      tags = {
        Environment = "Dev"
        Project     = "Azeemwebapp"
      }
    }
  }

  # Dependency on resource groups
  # "Dard: depends_on galat daal diya toh race condition ho jayega!"
  depends_on = [module.resource_groups]
}

module "db_virtual_network" {
  source = "./modules/azurerm_virtual_network"

  # DB VNet configuration
  virtual_networks = {
    db_vnet = {
      name                = "Azeemwebapp_Dev_WestCentralUS_DB_Vnet"
      resource_group_name = module.resource_groups.resource_group_names["db"]
      location            = "WestCentralUS"
      address_space       = ["172.16.0.0/26"]
      tags = {
        Environment = "Dev"
        Project     = "Azeemwebapp"
      }
    }
  }

  depends_on = [module.resource_groups]
}

# =============================================================================
# 3. SUBNETS (VNet par depend!)
# "Subnets - VNet ke chunks, har service ke liye alag subnet!"
# =============================================================================
module "app_subnets" {
  source = "./modules/azurerm_subnet"

  # App VNet subnets
  subnets = {
    webapp_subnet = {
      name                 = "Webapp_subnet"
      resource_group_name  = module.resource_groups.resource_group_names["app"]
      virtual_network_name = module.app_virtual_network.virtual_network_names["app_vnet"]
      address_prefixes     = ["10.0.1.0/24"]
      service_endpoints    = []
      delegation           = []
    }
    private_endpoint_subnet = {
      name                 = "Private_endpoint_subnet"
      resource_group_name  = module.resource_groups.resource_group_names["app"]
      virtual_network_name = module.app_virtual_network.virtual_network_names["app_vnet"]
      address_prefixes     = ["10.0.2.0/24"]
      service_endpoints    = []
      delegation           = []
    }
    app_gw_subnet = {
      name                 = "App_GW_Subnet"
      resource_group_name  = module.resource_groups.resource_group_names["app"]
      virtual_network_name = module.app_virtual_network.virtual_network_names["app_vnet"]
      address_prefixes     = ["10.0.3.0/24"]
      service_endpoints    = []
      delegation           = []
    }
  }

  depends_on = [module.app_virtual_network]
}

module "db_subnets" {
  source = "./modules/azurerm_subnet"

  # DB VNet subnet
  subnets = {
    db_subnet = {
      name                 = "DB_Subnet"
      resource_group_name  = module.resource_groups.resource_group_names["db"]
      virtual_network_name = module.db_virtual_network.virtual_network_names["db_vnet"]
      address_prefixes     = ["172.16.0.0/26"]
      service_endpoints    = ["Microsoft.Sql"]
      delegation           = []
    }
  }

  depends_on = [module.db_virtual_network]
}

# =============================================================================
# 4. APP SERVICE PLAN (Platform Service - Subnets par depend!)
# "App Service Plan - hosting infrastructure jisme web app chalega!"
# =============================================================================
module "app_service_plan" {
  source = "./modules/azurerm_app_service_plan"

  # App Service Plan configuration
  app_service_plans = {
    app_plan = {
      name                = "Azeemwebapp_Dev_AppPlan"
      resource_group_name = module.resource_groups.resource_group_names["app"]
      location            = "WestCentralUS"
      kind                = "Linux"
      sku_tier            = "Free"
      sku_size            = "F1"
      capacity            = 1
      per_site_scaling    = false
      tags = {
        Environment = "Dev"
        Project     = "Azeemwebapp"
      }
    }
  }

  depends_on = [module.app_subnets]
}

# =============================================================================
# 5. WEB APP (Application Resource - Plan + Subnet par depend!)
# "Web App - actual application jo chalega!"
# =============================================================================
module "web_app" {
  source = "./modules/azurerm_app_service"

  # Web App configuration
  web_apps = {
    webapp = {
      name                       = "AzeemwebappDev"
      resource_group_name        = module.resource_groups.resource_group_names["app"]
      location                   = "WestCentralUS"
      app_service_plan_id        = module.app_service_plan.app_service_plan_ids["app_plan"]
      app_service_plan_name      = module.app_service_plan.app_service_plan_names["app_plan"]
      runtime_stack              = "JAVA"
      java_version               = "17"
      java_container             = "JBOSS|EAP:7"
      java_container_version     = "7.4"
      os_type                    = "Linux"
      https_only                 = true
      vnet_integration_subnet_id = module.app_subnets.subnet_ids["webapp_subnet"]
      tags = {
        Environment = "Dev"
        Project     = "Azeemwebapp"
      }
    }
  }

  # Application Insights
  application_insights_enabled = true
  application_insights_name    = "Azeemwebapp_Dev_AppInsights"

  depends_on = [module.app_service_plan, module.app_subnets]
}

# =============================================================================
# 6. APPLICATION GATEWAY (Application Resource - Subnet + Web App par depend!)
# "Application Gateway - traffic router jo web app tak pahuchayega!"
# =============================================================================
module "application_gateway" {
  source = "./modules/azurerm_application_gateway"

  # Application Gateway configuration
  application_gateways = {
    app_gw = {
      name                     = "App_Gw01"
      resource_group_name      = module.resource_groups.resource_group_names["app"]
      location                 = "WestCentralUS"
      sku_name                 = "Standard_v2"
      sku_tier                 = "Standard_v2"
      capacity_min             = 1
      capacity_max             = 3
      vnet_subnet_id           = module.app_subnets.subnet_ids["app_gw_subnet"]
      backend_address_pool     = [module.web_app.web_app_default_hostnames["webapp"]]
      frontend_port            = 443
      ssl_certificate_path     = "C:/path/to/certificate.pfx" # TODO: Update this!
      ssl_certificate_password = "your-cert-password"         # TODO: Update this!
      request_timeout          = 30
      tags = {
        Environment = "Dev"
        Project     = "Azeemwebapp"
      }
    }
  }

  # Private IP address
  private_ip_address = "10.0.3.254"

  depends_on = [module.app_subnets, module.web_app]
}

# =============================================================================
# 7. STORAGE ACCOUNT (Application Resource - Resource Group par depend!)
# "Storage Account - files aur data ke liye!"
# =============================================================================
module "storage_account" {
  source = "./modules/azurerm_storage_account"

  # Storage Account configuration
  storage_accounts = {
    app_storage = {
      name                      = "devappnameenvt"
      resource_group_name       = module.resource_groups.resource_group_names["app"]
      location                  = "WestCentralUS"
      account_tier              = "Standard"
      account_replication_type  = "LRS"
      account_kind              = "StorageV2"
      enable_https_traffic_only = true
      allow_blob_public_access  = false
      tags = {
        Environment = "Dev"
        Project     = "Azeemwebapp"
      }
    }
  }

  depends_on = [module.resource_groups]
}

# =============================================================================
# 8. PRIVATE ENDPOINTS (Application Resource - Storage + Subnets par depend!)
# "Private Endpoints - secure connectivity ke liye!"
# =============================================================================
module "private_endpoints" {
  source = "./modules/azurerm_private_endpoint"

  # Private Endpoint configurations
  private_endpoints = {
    storage_blob_endpoint = {
      name                           = "storage-blob-pe"
      resource_group_name            = module.resource_groups.resource_group_names["app"]
      location                       = "WestCentralUS"
      subnet_id                      = module.app_subnets.subnet_ids["private_endpoint_subnet"]
      target_resource_id             = module.storage_account.storage_account_ids["app_storage"]
      target_resource_type           = "blob"
      private_connection_resource_id = module.storage_account.storage_account_ids["app_storage"]
      is_manual_connection           = false
      tags = {
        Environment = "Dev"
        Project     = "Azeemwebapp"
      }
    }
    storage_file_endpoint = {
      name                           = "storage-file-pe"
      resource_group_name            = module.resource_groups.resource_group_names["app"]
      location                       = "WestCentralUS"
      subnet_id                      = module.app_subnets.subnet_ids["private_endpoint_subnet"]
      target_resource_id             = module.storage_account.storage_account_ids["app_storage"]
      target_resource_type           = "file"
      private_connection_resource_id = module.storage_account.storage_account_ids["app_storage"]
      is_manual_connection           = false
      tags = {
        Environment = "Dev"
        Project     = "Azeemwebapp"
      }
    }
  }

  depends_on = [module.storage_account, module.app_subnets]
}

# =============================================================================
# =============================================================================
# OUTPUTS (Sab kuch deploy hone ke baad outputs milte hain)
# "Outputs - taali isse milti hai!"
# =============================================================================
output "resource_groups" {
  description = "Resource Group information"
  value = {
    names = module.resource_groups.resource_group_names
    ids   = module.resource_groups.resource_group_ids
  }
}

output "virtual_networks" {
  description = "Virtual Network information"
  value = {
    app = {
      name = module.app_virtual_network.virtual_network_names["app_vnet"]
      id   = module.app_virtual_network.virtual_network_ids["app_vnet"]
    }
    db = {
      name = module.db_virtual_network.virtual_network_names["db_vnet"]
      id   = module.db_virtual_network.virtual_network_ids["db_vnet"]
    }
  }
}

output "subnets" {
  description = "Subnet information"
  value = {
    webapp_subnet           = module.app_subnets.subnet_ids["webapp_subnet"]
    private_endpoint_subnet = module.app_subnets.subnet_ids["private_endpoint_subnet"]
    app_gw_subnet           = module.app_subnets.subnet_ids["app_gw_subnet"]
    db_subnet               = module.db_subnets.subnet_ids["db_subnet"]
  }
}

output "app_service_plan" {
  description = "App Service Plan information"
  value = {
    name = module.app_service_plan.app_service_plan_names["app_plan"]
    id   = module.app_service_plan.app_service_plan_ids["app_plan"]
  }
}

output "web_app" {
  description = "Web App information"
  sensitive   = true
  value = {
    name             = module.web_app.web_app_names["webapp"]
    id               = module.web_app.web_app_ids["webapp"]
    hostname         = module.web_app.web_app_default_hostnames["webapp"]
    app_insights_key = module.web_app.application_insights_instrumentation_key
  }
}

output "application_gateway" {
  description = "Application Gateway information"
  value = {
    name = module.application_gateway.application_gateway_names["app_gw"]
    id   = module.application_gateway.application_gateway_ids["app_gw"]
  }
}

output "storage_account" {
  description = "Storage Account information"
  value = {
    name = module.storage_account.storage_account_names["app_storage"]
    id   = module.storage_account.storage_account_ids["app_storage"]
    # Connection string is sensitive - uncomment if needed
    # connection_string = module.storage_account.storage_account_primary_connection_string["app_storage"]
  }
}

output "private_endpoints" {
  description = "Private Endpoint information"
  value = {
    blob = module.private_endpoints.private_endpoint_ids["storage_blob_endpoint"]
    file = module.private_endpoints.private_endpoint_ids["storage_file_endpoint"]
  }
}

# =============================================================================
# HOMEWORK (Ghar ka kaam - improvements ke liye)
# =============================================================================
# 1. Add NSG (Network Security Group) rules for subnet security
# 2. Add Private DNS zones for private endpoint resolution
# 3. Add Azure AD authentication for SQL Server
# 4. Add auto-scaling for Application Gateway (Premium tier)
# 5. Add WAF (Web Application Firewall) configuration
# 6. Add backup configuration for SQL Database
# 7. Add geo-replication for disaster recovery
# 8. Use Azure Key Vault for secrets management
# 9. Add diagnostic settings for monitoring
# 10. Add RBAC role assignments for access control
# =============================================================================
# "Arre bhai, yeh sab karoge toh expert ban jayoge!"
# "Padhai karo, homework karo, expert ban jao!"
# =============================================================================

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "b79e957b-f586-4818-929e-b8481e7d40de"
}

# najaf : 3899b5a6-b4f8-40f3-b6b1-2f6e0904597a"
#azeem: b79e957b-f586-4818-929e-b8481e7d40de
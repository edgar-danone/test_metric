terraform {
  required_version = ">= 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.108.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "cbbbf08a-89dc-4139-95b2-74b223239a5f"
}

data "azurerm_client_config" "current" {}

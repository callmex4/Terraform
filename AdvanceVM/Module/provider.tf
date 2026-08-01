terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.79.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "e5641063-663a-4203-b657-92aa70f8a9fa"

}
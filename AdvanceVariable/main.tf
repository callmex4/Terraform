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

  subscription_id = "448f5bc1-2cca-479b-80a7-aab8ffdc01b9"
}


resource "azurerm_resource_group" "rg1" {
  count=5
  name = var.Rgname[count.index]
  location = var.Location[count.index]
}

resource "azurerm_storage_account" "stg1" {
  count=5
  name = var.Storageaccount[count.index]
  resource_group_name = var.Rgname[count.index]
    location = var.Location[count.index]
  account_replication_type = "LRS"
  account_tier = "Standard"
}
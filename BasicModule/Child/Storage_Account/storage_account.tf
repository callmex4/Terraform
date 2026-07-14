resource "azurerm_storage_account" "stg1" {
    name = var.st
    resource_group_name = var.rg1
    location = "eastus"
    account_replication_type ="LRS"
    account_tier = "Standard"
}

resource "azurerm_linux_virtual_machine" "vm" {
name = var.vm_name
resource_group_name = var.rg_name
location = var.location
size = "Standard_D2s_v5"

admin_username = var.admin_username
admin_password = var.admin_password
disable_password_authentication = false
network_interface_ids = [var.nic_id]

os_disk {
caching = "ReadWrite"
storage_account_type = "Standard_LRS"
}

source_image_reference {
publisher = "Canonical"
offer = "ubuntu-24_04-lts" 
sku = "server"
version = "latest"
}
}
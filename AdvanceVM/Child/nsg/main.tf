resource "azurerm_network_security_group" "nsg" {
name = var.nsg_name
resource_group_name = var.rg_name
location = var.location

security_rule {
name = "AllowSSH"
priority = 100
direction ="Inbound"
access = "Allow"
protocol = "Tcp"
source_port_range = "*"
destination_port_range ="22"
source_address_prefix = "*"
destination_address_prefix = "*" 
}
}
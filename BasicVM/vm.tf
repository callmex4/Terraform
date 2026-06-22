terraform {
  required_version = ">= 1.0"
 
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
 
provider "azurerm" {
  features {}
  subscription_id = "448f5bc1-2cca-479b-80a7-aab8ffdc01b9"
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-saf"
  location = "west europe"
}
 
# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-shubh"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
 
# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-shubh"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
 
# Public IP
resource "azurerm_public_ip" "pip" {
  name                = "pip-shubh"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}
 
# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-shubh"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
 
  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
 
# NIC
resource "azurerm_network_interface" "nic" {
  name                = "nic-shubh"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
 
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}
 
# NSG Association
resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
 
# Linux VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-shubh"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v5"
 
  admin_username = "azureuser"
  admin_password = "P@ssw0rd1234!"
 
  disable_password_authentication = false
 
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]
 
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
 
  source_image_reference {
  publisher = "Canonical"
  offer     = "ubuntu-24_04-lts"
  sku       = "server"
  version   = "latest"

}
}
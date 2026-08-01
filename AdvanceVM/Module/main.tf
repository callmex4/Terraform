module "rgp" {
  source = "../Child/resource-group"

  rg_name  = "AzureVM"
  location = "Central India"
}

module "nic" {
  source       = "../Child/nic"
  nic_name     = "Azure-Nic"
  location     = module.rgp.location
  rg_name      = module.rgp.rg_name
  subnet_id    = module.sub.subnet_id
  public_ip_id = module.public_ip.public_ip_id
}

module "nsg" {
  source   = "../Child/nsg"
  nsg_name = "Azure-Nsg"
  rg_name  = module.rgp.rg_name
  location = module.rgp.location
}

module "nic-nsg" {
  source = "../Child/nsg-association"
  nic_id = module.nic.nic_id
  nsg_id = module.nsg.nsg_id
}

module "public_ip" {
  source         = "../Child/public-ip"
  rg_name        = module.rgp.rg_name
  location       = module.rgp.location
  public_ip_name = "Azure-pip"
}



module "sub" {
  source           = "../Child/subnet"
  subnet_name      = "Azure-Sub"
  rg_name          = module.rgp.rg_name
  vnet_name        = module.vnet.vnet_name
  address_prefixes = ["10.0.1.0/24"]
}

module "vm" {
  source         = "../Child/vm"
  vm_name        = "Azure-VM"
  admin_username = "Azure-Admin"
  admin_password = "Azure12345"
  rg_name        = module.rgp.rg_name
  location       = module.rgp.location
  nic_id         = module.nic.nic_id
}

module "vnet" {
  source        = "../Child/vnet"
  vnet_name     = "Azure-Vnet"
  rg_name       = module.rgp.rg_name
  location      = module.rgp.location
  address_space = ["10.0.0.0/16"]
}
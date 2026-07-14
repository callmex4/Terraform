module "resource_group" {
source = "../Child/Resource_Group"
}

module "storage_account" { 
    source = "../Child/Storage_Account"
}
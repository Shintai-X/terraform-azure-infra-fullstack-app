provider "azurerm" {
  features {}
  subscription_id="653b5c2f-c902-43fd-a871-92801c2acbf4"
}

module resource_groupe{
    source = "./resource_groupe"
    rg_name = "rg-fullstack-app"
    rg_location = "Spain Central"
}

module networking{
    source = "./networking"
    rg_name= module.resource_groupe.rg_name
    rg_location= module.resource_groupe.rg_location
}

module compute {
    source = "./compute"
    rg_name= module.resource_groupe.rg_name
    rg_location= module.resource_groupe.rg_location
    subnet_front_id = module.networking.subnet_front_id
    subnet_back_id = module.networking.subnet_back_id
    subnet_db_id = module.networking.subnet_db_id
    front_nic = module.networking.front_nic
    back_nic = module.networking.back_nic
    db_nic = module.networking.db_nic
}

module database {
    source = "./database"
    rg_name= module.resource_groupe.rg_name
    rg_location= module.resource_groupe.rg_location
    subnet_db_id = module.networking.subnet_db_id
}
output rg_name {
    value       = var.rg_name
}

output rg_location {
    value       = var.rg_location
}

output subnet_front_id {
    value = azurerm_subnet.subnet-front.id

}

output subnet_back_id {
    value = azurerm_subnet.subnet-back.id

}

output subnet_db_id {
    value = azurerm_subnet.subnet-db.id
}

output front_nic {
    value = azurerm_network_interface.front-nic.id

}

output back_nic {
    value = azurerm_network_interface.back-nic.id

}

output db_nic {
    value = azurerm_network_interface.db-nic.id
}




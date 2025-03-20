resource "azurerm_network_security_group" "vnet1-nsg" {
  name                = "vnet1-nsg"
  location            = var.rg_location 
  resource_group_name = var.rg_name

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range         = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-https"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range         = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-ssh"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range         = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "subnet-front" {
  name                 = "subnet-front"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "front-nsg-association" {
  subnet_id                 = azurerm_subnet.subnet-front.id
  network_security_group_id = azurerm_network_security_group.vnet1-nsg.id
}

resource "azurerm_subnet" "subnet-back" {
  name                 = "subnet-back"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "back-nsg-association" {
  subnet_id                 = azurerm_subnet.subnet-back.id
  network_security_group_id = azurerm_network_security_group.vnet1-nsg.id
}

resource "azurerm_subnet" "subnet-db" {
  name                 = "subnet-db"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "db-nsg-association" {
  subnet_id                 = azurerm_subnet.subnet-db.id
  network_security_group_id = azurerm_network_security_group.vnet1-nsg.id
}

resource "azurerm_network_interface" "front-nic" {
  name                = "front-nic"
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-front.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "back-nic" {
  name                = "back-nic"
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-back.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "db-nic" {
  name                = "db-nic"
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-db.id
    private_ip_address_allocation = "Dynamic"
  }
}
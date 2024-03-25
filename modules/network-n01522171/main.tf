resource "azurerm_virtual_network" "n01522171-VNET" {
  name                = var.vnet
  location            = var.location
  resource_group_name = var.network_rg
  address_space       = var.vnet_space

}
resource "azurerm_subnet" "n01522171-SUBNET" {
  name                 = var.subnet
  resource_group_name  = var.network_rg
  virtual_network_name = azurerm_virtual_network.n01522171-VNET.name
  address_prefixes     = var.subnet_space

}
resource "azurerm_network_security_group" "n01522171-nsg" {
  name                = var.nsg
  location            = var.location
  resource_group_name = var.network_rg

  security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  security_rule {
    name                       = "rule2"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule3"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule4"
    priority                   = 250
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Learning"
  }

}
resource "azurerm_subnet_network_security_group_association" "n01522171-nsgassoc" {
  subnet_id                 = azurerm_subnet.n01522171-SUBNET.id
  network_security_group_id = azurerm_network_security_group.n01522171-nsg.id
}


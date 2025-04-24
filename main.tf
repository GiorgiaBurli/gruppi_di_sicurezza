provider "azurerm" {
  features {}
  subscription_id = "8f9c403b-3155-4ba9-bbe0-69c7a950d225"
}

resource "azurerm_resource_group" "example-resource-group" {
  name     = "example-resource-group"
  location = "France Central"
}

resource "azurerm_network_security_group" "firewall-nsg" {
  name                = "firewallRulesNSG"
  location            = azurerm_resource_group.example-resource-group.location
  resource_group_name = azurerm_resource_group.example-resource-group.name

  # Porta 53 - UDP - Allow
  security_rule {
    name                       = "allow-dns-udp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "53"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Porta 22 - TCP - Allow
  security_rule {
    name                       = "allow-ssh"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Porta 8888 - TCP - Deny
  security_rule {
    name                       = "deny-web-8888"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8888"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Porta 1194 - UDP - Allow
  security_rule {
    name                       = "allow-vpn-udp"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "1194"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

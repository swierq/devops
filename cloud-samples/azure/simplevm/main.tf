# export ARM_PROVIDER_ENHANCED_VALIDATION=1                      
# export ARM_SKIP_PROVIDER_REGISTRATION=true





resource "azurerm_resource_group" "tfps" {
  name     = "${var.prefix}-resources"
  location = "West Europe"
  
}

resource "azurerm_ssh_public_key" "tfps" {
  name                = "tfps"
  location            = azurerm_resource_group.tfps.location
  resource_group_name = azurerm_resource_group.tfps.name
  public_key          = file("~/.ssh/id_rsa.pub")
}


resource "azurerm_virtual_network" "tfps" {
  name                = "${var.prefix}-network"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.tfps.location
  resource_group_name = azurerm_resource_group.tfps.name
}

resource "azurerm_public_ip" "tfps" {
  name                = "tfpsPublicIp1"
  resource_group_name = azurerm_resource_group.tfps.name
  location            = azurerm_resource_group.tfps.location
  allocation_method   = "Static"

  tags = {
    environment = "tfps"
  }
}


resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.tfps.name
  virtual_network_name = azurerm_virtual_network.tfps.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.tfps.location
  resource_group_name = azurerm_resource_group.tfps.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tfps.id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.tfps.location
  resource_group_name   = azurerm_resource_group.tfps.name
  network_interface_ids = [azurerm_network_interface.main.id]
  size               = "Standard_F2"
  

  admin_username = "tfps"  
  admin_ssh_key {
    username   = "tfps"
    public_key = azurerm_ssh_public_key.tfps.public_key
  }


  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  os_disk {    
    caching              = "ReadWrite"     
    storage_account_type = "Standard_LRS"
  }

  disable_password_authentication = true

  tags = {
    environment = "tfps"
  }
}


resource "azurerm_network_security_group" "tfps" {
  name                = format("%s-sg", var.prefix)
  location            = azurerm_resource_group.tfps.location
  resource_group_name = azurerm_resource_group.tfps.name
  tags = {
    environment = "tfps"
  }
}

resource "azurerm_network_security_rule" "allowssh" {
  name                        = "AllowSSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.tfps.name
  network_security_group_name = azurerm_network_security_group.tfps.name
}

resource "azurerm_network_security_rule" "blockall" {
  name                        = "BlockAll"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.tfps.name
  network_security_group_name = azurerm_network_security_group.tfps.name
}


resource "azurerm_subnet_network_security_group_association" "tfps" {
  subnet_id                 = azurerm_subnet.internal.id
  network_security_group_id = azurerm_network_security_group.tfps.id
}


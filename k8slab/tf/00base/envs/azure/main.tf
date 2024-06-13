resource "azurerm_resource_group" "rg" {
  name     = format("%s-resources", var.prefix)
  location = "West Europe"

}

resource "azurerm_ssh_public_key" "sshkey" {
  name                = format("%s-key", var.prefix)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  public_key          = file("~/.ssh/id_rsa.pub")
}


resource "azurerm_virtual_network" "net" {
  name                = format("%s-network", var.prefix)
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}


resource "azurerm_subnet" "subnet" {
  name                 = format("%s-subnet", var.prefix)
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.net.name
  address_prefixes     = ["10.0.1.0/24"]
}

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

resource "azurerm_kubernetes_cluster" "aks" {
  name                = format("%s-aks", var.prefix)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = format("%saks1", var.prefix)

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.prefix
  }
}

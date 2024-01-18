resource "azurerm_kubernetes_cluster" "aks" {
  name                = format("%s-aks", var.prefix)
  location            = data.terraform_remote_state.base.outputs.resource_group_location
  resource_group_name = data.terraform_remote_state.base.outputs.resource_group_name
  dns_prefix          = format("%s-aks", var.prefix)

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

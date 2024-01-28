resource "azurerm_kubernetes_cluster" "aks" {
  name                = format("%s-aks", var.prefix)
  location            = data.terraform_remote_state.base.outputs.resource_group_location
  resource_group_name = data.terraform_remote_state.base.outputs.resource_group_name
  dns_prefix          = format("%s-aks", var.prefix)

  default_node_pool {
    name                = "default"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 5
    node_count          = 1
    vm_size             = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.prefix
  }
}

# resource "azurerm_kubernetes_cluster_node_pool" "userapps" {
#   name                  = "userapps"
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
#   vm_size               = "Standard_DS2_v2"
#   enable_auto_scaling   = true
#   min_count             = 1
#   max_count             = 5
#   node_count            = 1
#   node_labels = {
#     dest = "userapps"
#   }
# }
resource "azurerm_log_analytics_workspace" "law" {
  name                = format("%s-laworkspace", var.prefix)
  location            = data.terraform_remote_state.base.outputs.resource_group_location
  resource_group_name = data.terraform_remote_state.base.outputs.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_data_collection_rule" "rule" {
  name                = format("%s-mdcr-aks", var.prefix)
  location            = data.terraform_remote_state.base.outputs.resource_group_location
  resource_group_name = data.terraform_remote_state.base.outputs.resource_group_name
  kind                = "Linux"

  destinations {
    log_analytics {
      name                  = "destination-log"
      workspace_resource_id = azurerm_log_analytics_workspace.law.id
    }
  }

  data_flow {
    destinations = ["destination-log"]
    streams      = ["Microsoft-ContainerInsights-Group-Default"]
  }

  data_sources {
    extension {
      extension_json = jsonencode({
        dataCollectionSettings = {
          enableContainerLogV2   = true
          interval               = "1m"
          namespaceFilteringMode = "Off"
        }
      })
      extension_name = "ContainerInsights"
      name           = "ContainerInsightsExtension"
      streams        = ["Microsoft-ContainerInsights-Group-Default"]
    }
  }

}

resource "azurerm_log_analytics_solution" "las" {
  solution_name         = "Containers"
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name
  location              = data.terraform_remote_state.base.outputs.resource_group_location
  resource_group_name   = data.terraform_remote_state.base.outputs.resource_group_name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Containers"
  }
}

resource "azurerm_monitor_data_collection_rule_association" "ra" {
  name                    = "${var.prefix}-dcra"
  target_resource_id      = azurerm_kubernetes_cluster.aks.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.rule.id
}

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

  oms_agent {
    log_analytics_workspace_id      = azurerm_log_analytics_workspace.law.id
    msi_auth_for_monitoring_enabled = true
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
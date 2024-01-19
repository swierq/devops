#tflint-ignore: terraform_unused_declarations
data "terraform_remote_state" "base" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstateqk4y3"
    container_name       = "tfstate"
    key                  = "k8slab01base.tfstate"

  }
}

data "terraform_remote_state" "k8s" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstateqk4y3"
    container_name       = "tfstate"
    key                  = "k8slab02k8s.tfstate"
  }
}


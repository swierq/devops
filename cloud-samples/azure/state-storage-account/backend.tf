terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstateqk4y3"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
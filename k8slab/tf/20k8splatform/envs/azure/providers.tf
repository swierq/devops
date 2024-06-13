provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.k8s.outputs.cluster_endpoint
  username               = data.terraform_remote_state.k8s.outputs.cluster_username
  password               = data.terraform_remote_state.k8s.outputs.cluster_password
  client_certificate     = base64decode(data.terraform_remote_state.k8s.outputs.cluster_client_certificate)
  client_key             = base64decode(data.terraform_remote_state.k8s.outputs.cluster_client_key)
  cluster_ca_certificate = base64decode(data.terraform_remote_state.k8s.outputs.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.k8s.outputs.cluster_endpoint
    username               = data.terraform_remote_state.k8s.outputs.cluster_username
    password               = data.terraform_remote_state.k8s.outputs.cluster_password
    client_certificate     = base64decode(data.terraform_remote_state.k8s.outputs.cluster_client_certificate)
    client_key             = base64decode(data.terraform_remote_state.k8s.outputs.cluster_client_key)
    cluster_ca_certificate = base64decode(data.terraform_remote_state.k8s.outputs.cluster_ca_certificate)
  }
}
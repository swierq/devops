
provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "tfminikube"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "tfminikube"
}


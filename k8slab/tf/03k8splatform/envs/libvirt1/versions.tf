terraform {
  required_version = "~> 1.5.6"
}



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



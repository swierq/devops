terraform {
  required_version = "~> 1.7.0"
  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "0.5.0"
    }
  }
}


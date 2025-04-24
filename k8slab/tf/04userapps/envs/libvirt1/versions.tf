terraform {
  required_version = "~> 1.7.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.8.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.25.0"
    }
  }
}



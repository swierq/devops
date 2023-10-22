terraform {
  required_providers {
    helm = {
      version = "~> 2.8.0"
    }
    kubernetes = {
      version = "~> 2.16.0"
    }
  }
  required_version = "~> 1.5.6"
}

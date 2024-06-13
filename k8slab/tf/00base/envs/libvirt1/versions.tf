terraform {
  required_version = "~> 1.5.6"
  required_providers {
    libvirt = {
      source  = "multani/libvirt"
      version = "0.6.3-1+4"
    }
  }
}
terraform {
  required_providers {
    libvirt = {
      source  = "multani/libvirt"
      version = "0.6.3-1+4"
    }
  }
  required_version = "~> 1.5.6"
}
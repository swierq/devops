resource "minikube_cluster" "this" {
  driver       = var.driver
  cluster_name = var.name
  addons       = var.addons
  vm           = true
  kvm_network  = var.kvm_network
}
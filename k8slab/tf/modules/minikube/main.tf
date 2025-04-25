resource "minikube_cluster" "this" {
  driver       = var.driver
  cluster_name = var.name
  addons       = var.addons
  vm           = true
  kvm_network  = var.kvm_network
  cpus         = var.cpus
  memory       = var.memory
  extra_config = [
    "kubelet.housekeeping-interval=10s"
  ]
}


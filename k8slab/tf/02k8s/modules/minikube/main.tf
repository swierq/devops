module "minikube" {
  source      = "../../../modules/minikube"
  name        = var.name
  driver      = "kvm2"
  kvm_network = var.kvm_network
  cpus        = 4
  memory      = 8192
}

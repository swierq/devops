module "minikube" {
  source      = "../../modules/minikube"
  name        = "tfminikube"
  kvm_network = data.terraform_remote_state.base.outputs.kvm_network
}


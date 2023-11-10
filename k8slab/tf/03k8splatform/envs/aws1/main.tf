module "argo" {
  count  = var.argo_enabled ? 1 : 0
  source = "../../modules/argo"
}

module "prometheus" {
  count  = var.prometheus_enabled ? 1 : 0
  source = "../../modules/prometheus"
}

module "albingress" {
  source       = "../../modules/albingress"
  cluster_name = data.terraform_remote_state.k8s.outputs.cluster_name
}
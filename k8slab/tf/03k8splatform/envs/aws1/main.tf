module "argo" {
  count  = var.argo_enabled ? 1 : 0
  source = "../../modules/argo"
}

module "prometheus" {
  count  = var.prometheus_enabled ? 1 : 0
  source = "../../modules/prometheus"
}
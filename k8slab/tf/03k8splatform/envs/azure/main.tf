module "argo" {
  source = "../../../modules/argocd"
}

module "prometheus" {
  source = "../../../modules/prometheus"
  helm_variables = [
    { name = "windowsMonitoring.enabled", value = "false" }
  ]
}
module "argocd" {
  count  = var.argo_enabled ? 1 : 0
  source = "../../../modules/argocd"
  helm_variables = [
    { name = "configs.params.server\\.insecure", value = "true" },
    { name = "configs.params.server\\.basehref", value = "/argocd" },
    { name = "configs.params.server\\.rootpath", value = "/argocd" },
    { name = "server.ingress.enabled", value = "true" },
    { name = "server.ingress.ingressClassName", value = "nginx" },
    { name = "server.ingress.pathType", value = "Prefix" },
    { name = "server.ingress.paths[0]", value = "/argocd" },
  ]
}

module "prometheus" {
  count  = var.prometheus_enabled ? 1 : 0
  source = "../../modules/prometheus"
}
module "albingress" {
  source       = "../../modules/albingress"
  cluster_name = data.terraform_remote_state.k8s.outputs.cluster_name
}


module "argo" {
  count  = var.argo_enabled ? 1 : 0
  source = "../../../modules/argocd"
  helm_variables = [
    { name = "configs.params.server\\.insecure", value = "true" },
    { name = "server.service.type", value = "NodePort" },
    { name = "server.ingress.enabled", value = "true" },
    { name = "server.ingress.ingressClassName", value = "alb" },
    { name = "server.ingress.pathType", value = "Prefix" },
    { name = "server.ingress.paths[0]", value = "/" },
    { name = "server.ingress.annotations.alb\\.ingress\\.kubernetes\\.io/scheme", value = "internet-facing" },
  ]
  depends_on = [module.albingress]
}

module "prometheus" {
  count  = var.prometheus_enabled ? 1 : 0
  source = "../../../modules/prometheus"
  helm_variables = [
    { name = "windowsMonitoring.enabled", value = "false" },
    { name = "grafana.service.type", value = "NodePort" },
    { name = "grafana.ingress.enabled", value = "true" },
    { name = "grafana.ingress.ingressClassName", value = "alb" },
    { name = "grafana.ingress.path", value = "/" },
    { name = "grafana.ingress.annotations.alb\\.ingress\\.kubernetes\\.io/scheme", value = "internet-facing" },
  ]
  depends_on = [module.albingress]
}


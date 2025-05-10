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
    { name = "server.ingress.hostname", value = "argocd.k8s.lab.test" },
  ]
}

module "prometheus" {
  count  = var.prometheus_enabled ? 1 : 0
  source = "../../../modules/prometheus"
  helm_variables = [
    { name = "windowsMonitoring.enabled", value = "false" },
    { name = "grafana.ingress.enabled", value = "true" },
    { name = "grafana.ingress.ingressClassName", value = "nginx" },
    { name = "grafana.ingress.path", value = "/" },
    { name = "grafana.ingress.hosts[0]", value = "grafana.k8s.lab.test" },
    { name = "grafana.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target", value = "/" },
  ]
}

module "strimzi" {
  count  = var.strimzi_enabled ? 1 : 0
  source = "../../../modules/strimzi"
  helm_variables = [
    { name = "watchNamespaces[0]", value = "appkafka" },
  ]

}

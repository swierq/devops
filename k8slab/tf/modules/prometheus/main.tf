resource "kubernetes_namespace" "prometheus" {
  metadata {
    name = var.prometheus_namespace
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = resource.kubernetes_namespace.prometheus.metadata[0].name
  dynamic "set" {
    for_each = var.helm_variables
    content {
      name  = set.value["name"]
      value = set.value["value"]
    }
  }
  depends_on = [
    kubernetes_namespace.prometheus
  ]
}

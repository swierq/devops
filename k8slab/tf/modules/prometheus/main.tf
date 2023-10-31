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
  set {
    name  = "windowsMonitoring.enabled"
    value = "false"
  }
  depends_on = [
    kubernetes_namespace.prometheus
  ]
}

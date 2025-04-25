resource "kubernetes_namespace" "strimzi" {
  metadata {
    name = var.strimzi_namespace
  }
}

resource "helm_release" "strimzi" {
  name       = "strimzi"
  repository = "https://strimzi.io/charts/"
  chart      = "strimzi-kafka-operator"
  version    = "0.45.0"
  namespace  = resource.kubernetes_namespace.strimzi.metadata[0].name
  dynamic "set" {
    for_each = var.helm_variables
    content {
      name  = set.value["name"]
      value = set.value["value"]
    }
  }
  depends_on = [
    kubernetes_namespace.strimzi
  ]
}

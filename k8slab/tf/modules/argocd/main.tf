resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace
  }
}


resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = resource.kubernetes_namespace.argocd.metadata[0].name

  dynamic "set" {
    for_each = var.helm_variables
    content {
      name  = set.value["name"]
      value = set.value["value"]
    }
  }

}

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
  depends_on = [
    kubernetes_namespace.argocd
  ]
}

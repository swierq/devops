resource "kubernetes_manifest" "argo_app" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind"       = "Application"
    "metadata" = {
      "finalizers" = [
        "resources-finalizer.argocd.argoproj.io",
      ]
      "labels" = {
        "name" = var.name
      }
      "name"      = var.name
      "namespace" = "argocd"
    }
    "spec" = {
      "destination" = {
        "namespace" = var.namespace
        "server"    = "https://kubernetes.default.svc"
      }
      "project"              = var.argo_project
      "revisionHistoryLimit" = 10
      "source" = {
        "path"           = var.repo_path
        "repoURL"        = var.repo_url
        "targetRevision" = "HEAD"
      }
      "syncPolicy" = {
        "automated" = {
          "allowEmpty" = true
          "prune"      = true
          "selfHeal"   = true
        }
        "retry" = {
          "backoff" = {
            "duration"    = "5s"
            "factor"      = 2
            "maxDuration" = "3m"
          }
          "limit" = 5
        }
        "syncOptions" = [
          "Validate=false",
          "CreateNamespace=true",
          "PrunePropagationPolicy=foreground",
          "PruneLast=true",
        ]
      }
    }
  }
}

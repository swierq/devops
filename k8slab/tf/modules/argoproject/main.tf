resource "kubernetes_manifest" "argo_project" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind"       = "AppProject"
    "metadata" = {
      "finalizers" = var.finalizers
      #"name" = "my-project"
      "name"      = var.name
      "namespace" = var.argo_namespace

    }
    "spec" = {
      "clusterResourceWhitelist" = [
        {
          "group" = "*"
          "kind"  = "*"
        },
      ]
      "description" = var.description
      "destinations" = [
        {

          "namespace" = var.namespace
          "server"    = "https://kubernetes.default.svc"
        },
        {
          "namespace" = "argocd"
          "server"    = "https://kubernetes.default.svc"
        },
      ]

      "namespaceResourceWhitelist" = [
        {
          "group" = "*"
          "kind"  = "*"
        },
      ]
      "roles" = [
        {
          "description" = format("Read-only privileges to %s", var.name)
          "groups" = [
            var.ro_group,
          ]
          "name" = "ro-role"
          "policies" = [
            format("p, proj:%s:ro-role, applications, get, %s/*, allow", var.name, var.name),
          ]
        },
        {
          "description" = "Sync privileges for guestbook-dev"
          "groups" = [
            var.rw_group,
          ]
          "name" = "rw-role"
          "policies" = [
            format("p, proj:%s:rw-role, applications, *, %s/*, allow", var.name, var.name),
          ]
        },
      ]
      "sourceRepos" = [
        "*",
      ]
    }
  }
}

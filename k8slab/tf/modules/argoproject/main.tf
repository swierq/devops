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
      #"description" = "Example Project"
      "description" = var.description
      "destinations" = [
        {
          #"namespace" = "guestbook"
          "namespace" = var.namespace
          "server"    = "https://kubernetes.default.svc"
        },
      ]
      # "namespaceResourceBlacklist" = [
      #   {
      #     "group" = ""
      #     "kind"  = "ResourceQuota"
      #   },
      #   {
      #     "group" = ""
      #     "kind"  = "LimitRange"
      #   },
      #   {
      #     "group" = ""
      #     "kind"  = "NetworkPolicy"
      #   },
      # ]
      "namespaceResourceWhitelist" = [
        # {
        #   "group" = "apps"
        #   "kind"  = "Deployment"
        # },
        # {
        #   "group" = "apps"
        #   "kind"  = "StatefulSet"
        # },
        {
          "group" = "*"
          "kind"  = "*"
        },
      ]
      # "orphanedResources" = {
      #   "warn" = false
      # }
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

resource "kubernetes_namespace" "appone" {
  metadata {
    labels = {
      app = "appone"
    }
    name = "appone"
  }
}

module "appone_project" {
  source         = "../../../modules/argoproject"
  name           = "appone"
  argo_namespace = "argocd"
  namespace      = resource.kubernetes_namespace.appone.metadata[0].name
  ro_group       = "ro"
  rw_group       = "rw"
}

module "appone_app" {
  source       = "../../../modules/argoapp"
  name         = "appone"
  argo_project = module.appone_project.name
  namespace    = resource.kubernetes_namespace.appone.metadata[0].name
  repo_url     = "https://github.com/swierq/devops/"
  repo_path    = format("k8slab/k8s/appone/argoapps/%s", var.apps_env)
}

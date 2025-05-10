resource "kubernetes_namespace" "appkafka" {
  metadata {
    labels = {
      app = "appkafka"
    }
    name = "appkafka"
  }
}

module "appkafka_project" {
  source         = "../../../modules/argoproject"
  name           = "appkafka"
  argo_namespace = "argocd"
  namespace      = resource.kubernetes_namespace.appkafka.metadata[0].name
  ro_group       = "ro"
  rw_group       = "rw"
}

module "appkafka_app" {
  source          = "../../../modules/argoapp"
  name            = "appkafka"
  argo_project    = module.appkafka_project.name
  namespace       = resource.kubernetes_namespace.appkafka.metadata[0].name
  repo_url        = "https://github.com/swierq/devops/"
  repo_path       = format("k8slab/k8s/appkafka/argoapps/%s", var.apps_env)
  target_revision = "master"
}

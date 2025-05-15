module "appkafka_project" {
  source         = "../../../modules/argoproject"
  name           = "appkafka"
  argo_namespace = "argocd"
  namespace      = "appkafka"
  ro_group       = "ro"
  rw_group       = "rw"
}

module "appkafka_app" {
  source          = "../../../modules/argoapp"
  name            = "appkafka"
  argo_project    = module.appkafka_project.name
  namespace       = "appkafka"
  repo_url        = "https://github.com/swierq/devops/"
  repo_path       = format("k8slab/k8s/appkafka/argoapps/%s", var.apps_env)
  target_revision = "master"
}

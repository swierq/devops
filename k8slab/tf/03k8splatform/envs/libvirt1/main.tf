module "argo" {
  count         = var.argo_enabled ? 1 : 0
  source        = "../../modules/argo"
}
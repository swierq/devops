module "alb-ingress-controller" {
  source       = "campaand/alb-ingress-controller/aws"
  version      = "2.0.0"
  cluster_name = var.cluster_name
}
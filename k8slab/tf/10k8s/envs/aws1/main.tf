module "eks" {
  source = "../../modules/eks"
  vpc    = data.terraform_remote_state.base.outputs.vpc
}

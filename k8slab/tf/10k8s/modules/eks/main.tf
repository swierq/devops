locals {
  cluster_name = format("eks-%s", var.name)
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.0.4"

  cluster_name    = local.cluster_name
  cluster_version = "1.28"

  vpc_id                         = var.vpc.id
  subnet_ids                     = var.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }

  #kms_key_administrators = ["arn:aws:iam::614815647221:user/dstephensadmin","arn:aws:iam::614815647221:user/Przemyslaw.Swierczek"]

  # aws-auth configmap

  tags = {
    Name = local.cluster_name
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    two = {
      name = "node-group-2"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}

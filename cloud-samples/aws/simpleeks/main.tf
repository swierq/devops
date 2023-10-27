locals {
  cluster_name = format("%s-eks", var.prefix)
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.0.4"

  cluster_name    = local.cluster_name
  cluster_version = "1.26"

  vpc_id                         = data.aws_vpc.default.id
  subnet_ids                     = data.aws_subnets.default.ids
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }

  #kms_key_administrators = ["arn:aws:iam::614815647221:user/dstephensadmin","arn:aws:iam::614815647221:user/Przemyslaw.Swierczek"]

  # aws-auth configmap
  # manage_aws_auth_configmap = true


  # aws_auth_users = [
  #   {
  #     userarn  = "arn:aws:iam::614815647221:user/dstephensadmin"
  #     username = "dstephensadmin"
  #     groups   = ["system:masters"]
  #   },
  #   {
  #     userarn  = "arn:aws:iam::614815647221:user/Przemyslaw.Swierczek"
  #     username = "Przemyslaw.Swierczek"
  #     groups   = ["system:masters"]
  #   },
  # ]

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
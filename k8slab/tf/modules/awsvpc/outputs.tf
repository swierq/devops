output "vpc" {
  value = {
    id              = resource.aws_vpc.vpc.id
    private_subnets = resource.aws_subnet.private[*].id
    public_subnets  = resource.aws_subnet.public[*].id
  }
}




#tflint-ignore: terraform_unused_declarations
data "terraform_remote_state" "base" {
  backend = "local"
  config = {
    path = "../../../01base/envs/aws1/terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-west-1"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}
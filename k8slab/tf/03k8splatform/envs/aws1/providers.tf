
provider "aws" {
  region = "eu-west-1"
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.k8s.outputs.cluster_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.k8s.outputs.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", data.terraform_remote_state.k8s.outputs.cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.k8s.outputs.cluster_endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.k8s.outputs.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", data.terraform_remote_state.k8s.outputs.cluster_name]
    }
  }
}
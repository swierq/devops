#tflint-ignore: terraform_unused_declarations
data "terraform_remote_state" "base" {
  backend = "s3"
  config = {
    bucket         = "tfstate-prz"
    key            = "states/aws1/00base.tfstate"
    dynamodb_table = "tfstate-prz"
    region         = "eu-west-1"
  }
}

data "terraform_remote_state" "k8s" {
  backend = "s3"
  config = {
    bucket         = "tfstate-prz"
    key            = "states/aws1/10k8s.tfstate"
    dynamodb_table = "tfstate-prz"
    region         = "eu-west-1"
  }
}

#tflint-ignore: terraform_unused_declarations
data "terraform_remote_state" "k8splatform" {
  backend = "s3"
  config = {
    bucket         = "tfstate-prz"
    key            = "states/aws1/20k8splatform.tfstate"
    dynamodb_table = "tfstate-prz"
    region         = "eu-west-1"
  }
}

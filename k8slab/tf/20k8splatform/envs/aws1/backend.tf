terraform {
  backend "s3" {
    bucket         = "tfstate-prz"
    key            = "states/aws1/20k8splatform.tfstate"
    dynamodb_table = "tfstate-prz"
    region         = "eu-west-1"
    encrypt        = true
  }
}


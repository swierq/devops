#tflint-ignore: terraform_unused_declarations
data "terraform_remote_state" "base" {
  backend = "s3"
  config = {
    bucket         = "tfstate-prz"
    key            = "states/aws1/01base.tfstate"
    dynamodb_table = "tfstate-prz"
    region         = "eu-west-1"
  }
}


#tflint-ignore: terraform_unused_declarations
data "terraform_remote_state" "base" {
  backend = "local"
  config = {
    path = "../../../01base/envs/aws1/terraform.tfstate"
  }
}

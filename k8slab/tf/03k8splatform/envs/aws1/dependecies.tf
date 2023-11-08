#tflint-ignore: terraform_unused_declarations
data "terraform_remote_state" "base" {
  backend = "local"
  config = {
    path = "../../../01base/envs/aws1/terraform.tfstate"
  }
}

data "terraform_remote_state" "k8s" {
  backend = "local"
  config = {
    path = "../../../02k8s/envs/aws1/terraform.tfstate"
  }
}

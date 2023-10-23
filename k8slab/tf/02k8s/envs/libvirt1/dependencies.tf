data "terraform_remote_state" "base" {
  backend = "local"
  config = {
    path = "../../../01base/envs/libvirt1/terraform.tfstate"
  }
}
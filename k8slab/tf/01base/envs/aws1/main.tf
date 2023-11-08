module "vpc" {
  source             = "../../../modules/awsvpc"
  vpc_name           = "tfeks"
  vpc_octet          = "7"
  availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  env_tags = {
    env = "tfeks"
  }
}

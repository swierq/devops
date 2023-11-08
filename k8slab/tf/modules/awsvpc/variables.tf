variable "vpc_octet" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "availability_zones" {
  type    = list(any)
  default = ["a"]
}


variable "env_tags" {
  type        = map(string)
  description = "Env Tags"
}

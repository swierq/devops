variable "name" {
  type        = string
  default     = "tfminikube"
  description = "Network Name."
}

variable "driver" {
  type        = string
  default     = "kvm2"
  description = "Network Name."
}


variable "addons" {
  type = list(string)
  default = ["dashboard",
    "default-storageclass",
    "ingress",
  "storage-provisioner"]

  description = "description"
}


variable "kvm_network" {
  type        = string
  default     = "default"
  description = "Network Name."
}
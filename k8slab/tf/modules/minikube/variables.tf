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
    "storage-provisioner",
    "metrics-server",
  ]

  description = "description"
}

variable "kvm_network" {
  type        = string
  default     = "default"
  description = "Network Name."
}

variable "cpus" {
  type        = number
  default     = 2
  description = "Number of CPUs to allocate to the Cluster."
}

variable "memory" {
  type        = string
  default     = "4G"
  description = "Memory to allocate to the Cluster."
}

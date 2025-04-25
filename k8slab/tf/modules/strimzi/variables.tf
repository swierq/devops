variable "strimzi_namespace" {
  type        = string
  default     = "strimzi"
  description = "Namesapace for Strimzi."
}

variable "helm_variables" {
  type = list(object({
    name  = string
    value = string
  }))
  default     = []
  description = "Helm Chart Variables."
}

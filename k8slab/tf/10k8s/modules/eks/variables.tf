variable "vpc" {
  type        = any
  description = "Vpc Data"
}

variable "name" {
  type        = string
  default     = "tfeks"
  description = "Name of the cluster."
}

variable "name" {
  type        = string
  description = "Name of the Argo Project."
}

variable "argo_namespace" {
  type        = string
  description = "Name of the Argo Project Namespace."
}

variable "namespace" {
  type        = string
  description = "Name of the Namespace linked to the project."
}

variable "description" {
  type        = string
  description = "Description of the Argo Project."
  default     = "TF created."
}

variable "finalizers" {
  type = list(string)
  default = [
    "resources-finalizer.argocd.argoproj.io",
  ]
  description = "Finalizers list"
}

variable "ro_group" {
  type        = string
  description = "ro_group"
  default     = "ro"
}

variable "rw_group" {
  type        = string
  description = "rw_group"
  default     = "rw"
}
variable "argocd_namespace" {
  type        = string
  default     = "argocd"
  description = "Namesapace for ArgoCD."
}

variable "helm_variables" {
  type = list(object({
    name  = string
    value = string
  }))
  default     = []
  description = "Helm Chart Variables."
}

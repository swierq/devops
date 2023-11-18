variable "prometheus_namespace" {
  type        = string
  default     = "monitoring"
  description = "Namesapace for Prometheus."
}

variable "helm_variables" {
  type = list(object({
    name  = string
    value = string
  }))
  default     = [{ name = "windowsMonitoring.enabled", value = "false" }]
  description = "Helm Chart Variables."
}

variable "argo_project" {
  type        = string
  description = "Argo Project Name."
  default     = "default"
}

variable "name" {
  type        = string
  description = "App Name."
}

variable "namespace" {
  type        = string
  description = "App Namespace."
}

variable "repo_url" {
  type        = string
  description = "Repository URL."
}

variable "repo_path" {
  type        = string
  description = "Repository Path."
}

variable "target_revision" {
  type        = string
  description = "Repository Target Revision."
  default     = "master"
}

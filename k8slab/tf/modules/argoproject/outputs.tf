output "name" {
  value = resource.kubernetes_manifest.argo_project.manifest.metadata.name
}

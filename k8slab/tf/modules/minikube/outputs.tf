output "name" {
  value       = var.name
  sensitive   = false
  description = "description"
}

output "host" {
  value       = resource.minikube_cluster.this.host
  sensitive   = false
  description = "description"
}

output "client_certificate" {
  value       = resource.minikube_cluster.this.client_certificate
  sensitive   = false
  description = "description"
}

output "client_key" {
  value       = resource.minikube_cluster.this.client_key
  sensitive   = false
  description = "description"
}


output "cluster_ca_certificate" {
  value       = resource.minikube_cluster.this.cluster_ca_certificate
  sensitive   = false
  description = "description"
}

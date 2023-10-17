output "name" {
  value       = resource.libvirt_network.this.name
  sensitive   = false
  description = "description"
}



output "public_ip" {
  value       = resource.azurerm_public_ip.tfps.ip_address
  sensitive   = false
  description = "description"
}

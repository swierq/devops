output "postgresql_server_fqdn" {
  value = resource.azurerm_postgresql_flexible_server.tfpg.fqdn
}

output "postgresql_server_login" {
  value = resource.azurerm_postgresql_flexible_server.tfpg.administrator_login
}

output "postgresql_server_password" {
  value     = resource.azurerm_postgresql_flexible_server.tfpg.administrator_password
  sensitive = true
}

output "postgresql_server_public_access" {
  value = resource.azurerm_postgresql_flexible_server.tfpg.public_network_access_enabled
}



# export ARM_PROVIDER_ENHANCED_VALIDATION=1                      
# export ARM_SKIP_PROVIDER_REGISTRATION=true


resource "azurerm_resource_group" "tfpg" {
  name     = "${var.prefix}-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "tfpg" {
  name                = "${var.prefix}-vn"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.tfpg.location
  resource_group_name = azurerm_resource_group.tfpg.name
}

resource "azurerm_subnet" "tfpg" {
  name                 = "${var.prefix}-sn"
  resource_group_name  = azurerm_resource_group.tfpg.name
  virtual_network_name = azurerm_virtual_network.tfpg.name
  address_prefixes     = ["10.10.1.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "tfpg" {
  name                = "${var.prefix}.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.tfpg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "tfpg" {
  name                  = "${var.prefix}VnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.tfpg.name
  virtual_network_id    = azurerm_virtual_network.tfpg.id
  resource_group_name   = azurerm_resource_group.tfpg.name
}

resource "azurerm_postgresql_flexible_server" "tfpg" {
  name                = "${var.prefix}-psql-server"
  location            = azurerm_resource_group.tfpg.location
  resource_group_name = azurerm_resource_group.tfpg.name

  sku_name              = "B_Standard_B1ms"
  version               = "15"
  storage_mb            = 32768
  backup_retention_days = 7

  administrator_login    = var.login
  administrator_password = var.password

  depends_on = [azurerm_private_dns_zone_virtual_network_link.tfpg]

  tags = {
    Environment = var.prefix
  }
}

resource "azurerm_postgresql_flexible_server_database" "tfpg" {
  name      = "${var.prefix}-db"
  server_id = azurerm_postgresql_flexible_server.tfpg.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "tfpg" {
  name             = "${var.prefix}-fw-AllowAll"
  server_id        = azurerm_postgresql_flexible_server.tfpg.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}

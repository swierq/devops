resource "libvirt_network" "this" {
  name      = var.name
  mode      = "nat"
  domain    = var.domain
  addresses = [var.cidr]
  dns {
    enabled    = true
    local_only = false
  }
}

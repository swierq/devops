variable "prefix" {
  type    = string
  default = "tfpg"
}
variable "login" {
  type    = string
  default = "psqladmin"
}
variable "password" {
  description = "The Administrator password for the PostgreSQL"
  type        = string
  sensitive   = true
}
variable "prefix" {
  default = "tfpg"
}
variable "login" {
  default = "psqladmin"
}
variable "password" {
  description = "The Administrator password for the PostgreSQL"
  type        = string
  sensitive = true
}
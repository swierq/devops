variable "cidr" {
  type        = string
  default     = "192.168.123.0/24"
  description = "Cidr for libvirt network."
}

variable "domain" {
  type        = string
  default     = ".libvirt.local"
  description = "Dns domain Name for the network."
}

variable "name" {
  type        = string
  default     = "tfnet1"
  description = "Network Name."
}

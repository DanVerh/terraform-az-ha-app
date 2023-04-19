variable "location" {
  description = "Location"
}

variable "rg" {
  description = "Resource Group"
}

variable "subnetid" {
  description = "Subnet ID"
}

variable "username" {
  description = "Admin Username"
  sensitive   = true
}

variable "password" {
  description = "Admin Password"
  sensitive   = true
}

variable "vmname" {
  description = "Virtual Machine name"
}

variable "pip" {
  description = "Public IP address ID"
}

variable "ha" {
  type = bool
  default = false
}

variable "backend_address_pool_id" {}
variable "as_id" {}
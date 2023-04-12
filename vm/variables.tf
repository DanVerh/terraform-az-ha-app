variable "location" {
  description = "Location"
  type = list
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

variable "ha" {
  type = bool
  default = false
}
variable "location" {
  validation {
    condition = contains(["East US", "North Europe", "Central"], var.location)
    error_message = "Invalid location value: ${var.location}"
  }
}

variable "rg" {}

variable "is_rg_required" {
  description = "Do you want to create a new RG for this app?"
  type = bool
  default = true
}

variable "ha" {
  description = "Does this app require high availability (two VMs in the pool with LB)?"
  type = bool
  default = false
}


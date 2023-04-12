variable "rg_name" {}
variable "rg_location" {}

variable "is_rg_required" {
  description = "Is creation of RG required or you already have one"
  default = false
  type = bool
}
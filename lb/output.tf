output "backend_address_pool_id" {
  value = azurerm_lb_backend_address_pool.this.id
}

output "as_id" {
  value = azurerm_availability_set.this.id
}
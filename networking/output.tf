output "vnet_name" {
  value = azurerm_virtual_network.this.name
}

output "subnet_name" {
  value = azurerm_subnet.this.name
}

output "subnet_id" {
  value = azurerm_subnet.this.id
}

output "pip_name" {
  value = azurerm_public_ip.this.name
}

output "pip_id" {
  value = azurerm_public_ip.this.id
}

output "pip_ip" {
  value = azurerm_public_ip.this.ip_address
}
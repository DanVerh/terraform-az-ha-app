resource "azurerm_availability_set" "this" {
  name                = "availability-set"
  location            = var.location
  resource_group_name = var.rg

  platform_update_domain_count = 2
  platform_fault_domain_count  = 2
}

resource "azurerm_lb" "this" {
  name                = "lb"
  location            = var.location
  resource_group_name = var.rg

  frontend_ip_configuration {
    name                          = "PublicIPAddress"
    public_ip_address_id          = var.pip
  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  loadbalancer_id = azurerm_lb.this.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "this" {
  loadbalancer_id = azurerm_lb.this.id
  name            = "http-running-probe"
  protocol        = "Http"
  request_path    = "/"
  port            = 80
}

resource "azurerm_lb_rule" "this" {
   loadbalancer_id                = azurerm_lb.this.id
   name                           = "http"
   protocol                       = "Tcp"
   frontend_port                  = 80
   backend_port                   = 80
   backend_address_pool_ids        = [azurerm_lb_backend_address_pool.this.id]
   frontend_ip_configuration_name = "PublicIPAddress"
   probe_id                       = azurerm_lb_probe.this.id
}
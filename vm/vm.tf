resource "azurerm_network_interface" "this" {
  count = (var.ha ? 2 : 1)
  name                = format("${var.vmname}-nic-%d", count.index + 1)
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnetid
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.pip
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  count = (var.ha ? 2 : 1)
  name                = format("${var.vmname}-%d", count.index + 1)
  resource_group_name = var.rg
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.username
  admin_password      = var.password
  disable_password_authentication = false
  availability_set_id = var.as_id
  user_data = base64encode(templatefile("./script/webserver.tftpl", {
    vm = format("${var.vmname}-%d", count.index + 1)
  }))


  network_interface_ids = [
    azurerm_network_interface.this[count.index].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "this" {
  count               = var.ha ? 2 : 0

  network_interface_id = azurerm_network_interface.this[count.index].id
  ip_configuration_name = "internal"
  backend_address_pool_id = var.backend_address_pool_id
}
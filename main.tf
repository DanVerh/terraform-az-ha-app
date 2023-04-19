provider "azurerm" {
  features {}
}

data "azurerm_key_vault" "this" {
  name                = "danverh"
  resource_group_name = "test"
}

data "azurerm_key_vault_secret" "this" {
  name         = "vmss-password"
  key_vault_id = data.azurerm_key_vault.this.id
}

module "rg" {
  source = "./rg"

  count = var.is_rg_required ? 1 : 0
  rg_name = var.rg
  rg_location = var.location
}

module "network" {
  source = "./networking"

  rg_name = var.rg
  location = var.location
  vnet_name = "vnet"
  vnet_address = "10.0.0.0/26"
  subnet_name = "subnet1"
  subnet_address = "10.0.0.0/28"
  pip_name = "pipdanverh"

  depends_on = [
    module.rg
  ]
}

module "lb" {
  source = "./lb"

  count = var.ha ? 1 : 0
  rg = var.rg
  location = var.location
  pip = module.network.pip_id

  depends_on = [
    module.rg
  ]
}

module "vm" {
  source = "./vm"

  location = var.location
  rg = var.rg
  subnetid = module.network.subnet_id 
  vmname = "vm"
  username = "danverh"
  password = data.azurerm_key_vault_secret.this.value
  pip = var.ha ? null : module.network.pip_id
  backend_address_pool_id = module.lb[0].backend_address_pool_id
  as_id = module.lb[0].as_id
  ha = var.ha

  depends_on = [
    module.rg,
    module.lb
  ]
}
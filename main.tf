provider "azurerm" {
  features {}
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

data "azurerm_key_vault" "this" {
  name                = "danverh"
  resource_group_name = "test"
}

data "azurerm_key_vault_secret" "this" {
  name         = "vmss-password"
  key_vault_id = data.azurerm_key_vault.this.id
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
  ha = var.ha
}
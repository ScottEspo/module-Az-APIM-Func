locals {
  resource_group_name     = var.create_rg ? var.rg_name : data.azurerm_resource_group.SN[0].name
  resource_group_location = var.create_rg ? var.resource_group_location : data.azurerm_resource_group.SN[0].location
  storage_account_name    = "${lower(replace(var.name, "/\\s+/", "_"))}${random_string.azurerm_api_management_name.result}}"
  storage_acct_name_short = substr(local.storage_account_name, 0, 24)
}
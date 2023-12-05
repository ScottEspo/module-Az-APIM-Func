locals {
  resource_group_name     = var.create_rg ? var.rg_name : data.azurerm_resource_group.SN[0].name
  resource_group_location = var.create_rg ? var.resource_group_location : data.azurerm_resource_group.SN[0].location
}
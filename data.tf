## Lookup existing Resource Group
data "azurerm_resource_group" "SN" {
  count = var.create_rg ? 0 : 1
  name  = var.rg_name
}
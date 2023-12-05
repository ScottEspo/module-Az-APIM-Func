output "cosmosdb_connectionstrings" {
  value     = azurerm_cosmosdb_account.pizza_db_acct.connection_strings
  sensitive = true
}

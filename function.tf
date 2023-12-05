resource "azurerm_storage_account" "example" {
  name                     = local.storage_acct_name_short
  resource_group_name      = local.resource_group_name
  location                 = local.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "null_resource" "az_func_zip_upload" {
  triggers = {
    requirements_md5 = "${filemd5("${var.functionappname}")}"
  }
  provisioner "local-exec" {
    command     = "az functionapp deployment source config-zip -g ${local.resource_group_name} -n ${azurerm_windows_function_app.example.name} --src ${var.functionappname}"
    working_dir = path.module
  }
  depends_on = [azurerm_windows_function_app.example]
}

resource "azurerm_service_plan" "example" {
  name                = "${var.name}-service-plan"
  resource_group_name = local.resource_group_name
  location            = local.resource_group_location
  os_type             = "Windows"
  sku_name            = "Y1"
}
resource "azurerm_windows_function_app" "example" {
  name                = "${var.name}-app"
  resource_group_name = local.resource_group_name
  location            = local.resource_group_location

  storage_account_name        = azurerm_storage_account.example.name
  storage_account_access_key  = azurerm_storage_account.example.primary_access_key
  service_plan_id             = azurerm_service_plan.example.id
  client_certificate_mode     = "Required"
  https_only                  = true
  functions_extension_version = "~4"



  site_config {
    cors {
      allowed_origins = ["*"]
    }
  }

  app_settings = {
    https_only               = true
    FUNCTIONS_WORKER_RUNTIME = "node"
    WEBSITE_NODE_DEFAULT_VERSION = "~20"
    WEBSITE_RUN_FROM_PACKAGE  = "0"
    WEBSITE_DISABLE_ZIP_CACHE = "0"
    COSMOS_CONNECTION_STRING  = "${azurerm_cosmosdb_account.pizza_db_acct.connection_strings[0]}"
  }

}
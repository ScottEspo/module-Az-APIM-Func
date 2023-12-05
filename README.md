# Azure APIM Example


```
module "pizza_toppings" {
  source          = "../"
  name            = "PizzaToppings"
  create_rg       = false
  rg_name         = "1-092ed5cc-playground-sandbox"
  functionappname = "${path.cwd}/toppings.zip"
  api_operations  = local.api_operations
}
```

![WHAT WE ARE BUILDING!](./arch.jpg "What we are building")
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~>3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>3.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | ~>3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management.api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |
| [azurerm_api_management_api.example_manual](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_operation.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation) | resource |
| [azurerm_api_management_product.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product) | resource |
| [azurerm_api_management_product_api.example_mock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_cosmosdb_account.pizza_db_acct](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_service_plan.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_storage_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_windows_function_app.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app) | resource |
| [null_resource.az_func_zip_upload](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_string.azurerm_api_management_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_resource_group.SN](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_operations"></a> [api\_operations](#input\_api\_operations) | Map of API Operations to create for API being created | <pre>map(object({<br>    operation_id = string<br>    display_name = string<br>    method       = string<br>    url_template = string<br>    description  = string<br>  }))</pre> | n/a | yes |
| <a name="input_create_rg"></a> [create\_rg](#input\_create\_rg) | set to true if you are creating a new Resource Group for all resources | `bool` | `false` | no |
| <a name="input_functionappname"></a> [functionappname](#input\_functionappname) | n/a | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `""` | no |
| <a name="input_publisher_email"></a> [publisher\_email](#input\_publisher\_email) | The email address of the owner of the service | `string` | `"scott.esposito@daugherty.com"` | no |
| <a name="input_publisher_name"></a> [publisher\_name](#input\_publisher\_name) | The name of the owner of the service | `string` | `"publisher"` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location for all resources. | `string` | `"westus"` | no |
| <a name="input_resource_group_name_prefix"></a> [resource\_group\_name\_prefix](#input\_resource\_group\_name\_prefix) | Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription. | `string` | `"rg"` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | n/a | `string` | `"1-609c3cff-playground-sandbox"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The pricing tier of this API Management service | `string` | `"Developer"` | no |
| <a name="input_sku_count"></a> [sku\_count](#input\_sku\_count) | The instance size of this API Management service. | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cosmosdb_connectionstrings"></a> [cosmosdb\_connectionstrings](#output\_cosmosdb\_connectionstrings) | n/a |
<!-- END_TF_DOCS -->
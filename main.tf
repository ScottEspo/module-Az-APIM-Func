################################################
### Create Random Values
################################################

resource "random_string" "azurerm_api_management_name" {
  length  = 13
  lower   = true
  numeric = false
  special = false
  upper   = false
}

################################################
### Create a Resource Group
################################################
# looking up existing RG from data.tf

resource "azurerm_resource_group" "rg" {
  count    = var.create_rg ? 1 : 0
  name     = var.rg_name
  location = var.resource_group_location
}

################################################
### Create APIM Instance
################################################

resource "azurerm_api_management" "api" {
  name = "apiservice${random_string.azurerm_api_management_name.result}"
  # location = azurerm_resource_group.rg.location   ## looking up existing RG from data.tf
  location = local.resource_group_location
  # resource_group_name = azurerm_resource_group.rg.name   ## looking up existing RG from data.tf
  resource_group_name = local.resource_group_name
  publisher_email     = var.publisher_email
  publisher_name      = var.publisher_name
  sku_name            = "${var.sku}_${var.sku_count}"
}


################################################
### Create and publish a product
### https://learn.microsoft.com/en-us/azure/api-management/api-management-howto-add-products?tabs=azure-portal
### https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product
### https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api
################################################

resource "azurerm_api_management_product" "example" {
  product_id          = "${var.name}-product"
  api_management_name = azurerm_api_management.api.name
  # resource_group_name = azurerm_resource_group.rg.name    ## looking up existing RG from data.tf
  resource_group_name   = local.resource_group_name
  display_name          = "${var.name} Product"
  subscription_required = false
  approval_required     = false
  published             = true
}



################################################
### Create another API from scratch, assign it to a Product and add GET Operation to it
### https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation
################################################

resource "azurerm_api_management_api" "example_manual" {
  name = "${var.name}-api"
  # resource_group_name = azurerm_resource_group.rg.name    ## looking up existing RG from data.tf
  resource_group_name = local.resource_group_name
  api_management_name = azurerm_api_management.api.name
  revision            = "1"
  display_name        = "${var.name}api"
  protocols           = ["https"]
  service_url         = "https://${azurerm_windows_function_app.example.default_hostname}/api"
}

resource "azurerm_api_management_product_api" "example_mock" {
  api_name            = azurerm_api_management_api.example_manual.name
  product_id          = azurerm_api_management_product.example.product_id
  api_management_name = azurerm_api_management.api.name
  # resource_group_name = azurerm_resource_group.rg.name    ## looking up existing RG from data.tf
  resource_group_name = local.resource_group_name
}

resource "azurerm_api_management_api_operation" "example" {
  for_each            = var.api_operations
  operation_id        = lookup(each.value, "operation_id")
  api_name            = azurerm_api_management_api.example_manual.name
  api_management_name = azurerm_api_management.api.name
  # resource_group_name = azurerm_resource_group.rg.name    ## looking up existing RG from data.tf
  resource_group_name = local.resource_group_name
  display_name        = lookup(each.value, "display_name", "")
  method              = lookup(each.value, "method", "")
  url_template        = lookup(each.value, "url_template", "")
  description         = lookup(each.value, "description", "")
  response {
    status_code = 200
    representation {
      content_type = "application/json"
      example {
        name  = "default"
        value = "{ \"sampleField\" : \"test\" }"
      }
    }
  }
}

# resource "azurerm_api_management_api_operation" "initiate_operation" {
#   operation_id        = "initiate-toppings"
#   api_name            = azurerm_api_management_api.example_manual.name
#   api_management_name = azurerm_api_management.api.name
#   # resource_group_name = azurerm_resource_group.rg.name    ## looking up existing RG from data.tf
#   resource_group_name = local.resource_group_name
#   display_name        = "Initiate Toppings"
#   method              = "GET"
#   url_template        = "/toppings-init"
#   description         = "Initiate Toppings"
#   response {
#     status_code = 200
#     representation {
#       content_type = "application/json"
#       example {
#         name  = "default"
#         value = "{ \"sampleField\" : \"test\" }"
#       }
#     }
#   }
# }



################################################
### Create a MOCK Policy
### Tutorial: Mock API responses: https://learn.microsoft.com/en-us/azure/api-management/mock-api-responses?tabs=azure-portal
################################################

# resource "azurerm_api_management_api_operation_policy" "example" {
#   api_name            = azurerm_api_management_api.example_manual.name
#   api_management_name = azurerm_api_management.api.name
#   # resource_group_name = azurerm_resource_group.rg.name    ## looking up existing RG from data.tf
#   resource_group_name = local.resource_group_name
#   operation_id        = azurerm_api_management_api_operation.example.operation_id

#   xml_content = <<XML
# <!--
#             IMPORTANT:
#             - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.
#             - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.
#             - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.
#             - To add a policy, place the cursor at the desired insertion point and select a policy from the sidebar.
#             - To remove a policy, delete the corresponding policy statement from the policy document.
#             - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.
#             - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.
#             - Policies are applied in the order of their appearance, from the top down.
#             - Comments within policy elements are not supported and may disappear. Place your comments between policy elements or at a higher level scope.
#         -->
#         <policies>
#                 <inbound>
#                         <base />
#                         <mock-response status-code="200" content-type="application/json" />
#                 </inbound>
#                 <backend>
#                         <base />
#                 </backend>
#                 <outbound>
#                         <base />
#                 </outbound>
#                 <on-error>
#                         <base />
#                 </on-error>
#         </policies>
# XML
# }

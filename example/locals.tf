locals {
  api_operations = {
    "get-toppings" = {
      operation_id = "get-toppings"
      display_name = "Get Toppings"
      method       = "GET"
      url_template = "/get-toppings"
      description  = "Get Toppings"
    },
    "init-toppings" = {
      operation_id = "initiate-toppings"
      display_name = "Initiate Toppings"
      method       = "GET"
      url_template = "/toppings-init"
      description  = "Initiate Toppings"
    }
  }
}
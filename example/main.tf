module "pizza_toppings" {
  source          = "../"
  name            = "PizzaToppings"
  create_rg       = false
  rg_name         = "1-092ed5cc-playground-sandbox"
  functionappname = "./toppings.zip"
  api_operations  = local.api_operations
}
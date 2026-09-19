module "resource_group" {
  source  = "app.terraform.io/leshawn-rice/resource-group/azurerm"
  version = "1.1.1"

  # name     = module.names.resource_group.name
  application = var.application
  environment = var.environment
  location    = var.location
}

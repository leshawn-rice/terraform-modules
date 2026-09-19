resource "azurerm_user_assigned_identity" "this" {
  name                = var.name != null ? var.name : module.name[0].name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags != null ? var.tags : module.tags[0].tags
}

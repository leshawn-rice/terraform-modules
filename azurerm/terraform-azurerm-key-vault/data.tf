data "azurerm_client_config" "current" {
  count = var.tenant_id == null ? 1 : 0
}

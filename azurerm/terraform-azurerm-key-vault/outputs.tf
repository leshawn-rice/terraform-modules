output "name" {
  value       = azurerm_key_vault.this.name
  description = "The Name of the Key Vault."
}

output "id" {
  value       = azurerm_key_vault.this.id
  description = "The ID of the Key Vault."
}

output "vault_uri" {
  value       = azurerm_key_vault.this.vault_uri
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
}

output "secret_ids" {
  value       = { for name, secret in azurerm_key_vault_secret.this : name => secret.id }
  description = "A map of secret name to the versionless ID of the created secret."
}

output "secret_versionless_ids" {
  value       = { for name, secret in azurerm_key_vault_secret.this : name => secret.versionless_id }
  description = "A map of secret name to the versionless ID of the created secret, suitable for Key Vault references in App Settings."
}

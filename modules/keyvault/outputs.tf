output "key_vault_id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault.main.id
}

output "key_vault_name" {
  description = "Key vault name"
  value       = azurerm_key_vault.main.name
}

output "key_vault_uri" {
  description = "The URI of Key Vault"
  value       = azurerm_key_vault.main.vault_uri
}

output "sql_connection_string_secret_uri" {
  description = "Used in app service settings with key vault ref"
  value       = azurerm_key_vault_secret.sql_connection_string.id
}

output "sql_connection_string_secret_name" {
  description = "The name of SQL connection string secret"
  value       = azurerm_key_vault_secret.sql_connection_string.name
}
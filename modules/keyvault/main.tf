resource "azurerm_key_vault" "main" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  enabled_for_disk_encryption     = false

  enable_rbac_authorization = false

  public_network_access_enabled = true
  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
  tags = var.tags
}

#Grant permission to the deployer
resource "azurerm_key_vault_access_policy" "deployer" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = var.tenant_id
  object_id    = var.deployer_object_id
  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Purge",
    "Recover"
  ]
  key_permissions = [
    "Get",
    "List",
    "Create",
    "Delete"
  ]
  certificate_permissions = [
    "Get",
    "List"
  ]
}

#Store db connection string in keyvault
resource "azurerm_key_vault_secret" "sql_connection_string" {
  name         = "SqlConnectionString"
  value        = var.sql_connection_string
  key_vault_id = azurerm_key_vault.main.id

  content_type = "text/plain"
  tags = {
    purpose = "database-connection"
  }

  depends_on = [azurerm_key_vault_access_policy.deployer]
}

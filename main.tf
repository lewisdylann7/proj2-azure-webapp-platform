data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

module "observability" {
  source                       = "./modules/observability"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = var.location
  log_analytics_workspace_name = var.log_analytics_workspace_name
  application_insights_name    = var.application_insights_name
  tags                         = local.common_tags
}

module "database" {
  source              = "./modules/database"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  sql_server_name     = var.sql_server_name
  sql_database_name   = var.sql_database_name
  sql_admin_username  = var.sql_admin_username
  sql_admin_password  = var.sql_admin_password
  tags                = local.common_tags
}

module "keyvault" {
  source                = "./modules/keyvault"
  resource_group_name   = azurerm_resource_group.main.name
  location              = var.location
  key_vault_name        = var.key_vault_name
  tenant_id             = data.azurerm_client_config.current.tenant_id
  deployer_object_id    = data.azurerm_client_config.current.object_id
  sql_connection_string = local.sql_connection_string
  tags                  = local.common_tags
  depends_on            = [module.database]
}

module "appservice" {
  source                                 = "./modules/appservice"
  resource_group_name                    = azurerm_resource_group.main.name
  location                               = var.location
  app_service_plan_name                  = var.app_service_plan_name
  web_app_name                           = var.web_app_name
  key_vault_id                           = module.keyvault.key_vault_id
  key_vault_uri                          = module.keyvault.key_vault_uri
  application_insights_connection_string = module.observability.application_insights_connection_string
  application_insights_key               = module.observability.application_insights_instrumentation_key
  tags                                   = local.common_tags

  depends_on = [module.keyvault]
}

resource "azurerm_key_vault_access_policy" "webapp_access" {
  key_vault_id = module.keyvault.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.appservice.web_app_principal_id
  secret_permissions = [
    "Get",
    "List"
  ]
}

resource "azurerm_monitor_diagnostic_setting" "keyvault_diagnostics" {
  name                       = "diag-keyvault-logs"
  target_resource_id         = module.keyvault.key_vault_id
  log_analytics_workspace_id = module.observability.log_analytics_workspace_id
  #capture audit events (who accessed what)
  enabled_log {
    category = "AuditEvent"
  }
  enabled_metric {
    category = "AllMetrics"
  }
}

resource "azurerm_monitor_diagnostic_setting" "sql_diagnostics" {
  name                       = "diag-sql-logs"
  target_resource_id         = module.database.sql_database_id
  log_analytics_workspace_id = module.observability.log_analytics_workspace_id
  enabled_log {
    category = "SQLInsights"
  }
  enabled_log {
    category = "Errors"
  }
  enabled_metric {
    category = "Basic"
  }
}

resource "azurerm_monitor_diagnostic_setting" "appservice_diagnostics" {
  name                       = "diag-appservice-logs"
  target_resource_id         = module.appservice.web_app_principal_id
  log_analytics_workspace_id = module.observability.log_analytics_workspace_id
  enabled_log {
    category = "AppServiceHTTPLogs"
  }
  enabled_log {
    category = "AppServiceConsoleLogs"
  }
  enabled_log {
    category = "AppServiceAppLogs"
  }
  enabled_metric {
    category = "AllMetrics"
  }
}

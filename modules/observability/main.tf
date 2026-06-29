resource "azurerm_log_analytics_workspace" "main" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
  daily_quota_gb      = -1
  #For resources outside azure to send data
  internet_ingestion_enabled = true
  #To query logs from outide Azure
  internet_query_enabled = true
  tags                   = var.tags
}

resource "azurerm_application_insights" "main" {
  name                                 = var.application_insights_name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  workspace_id                         = azurerm_log_analytics_workspace.main.id
  application_type                     = "web"
  retention_in_days                    = 30
  daily_data_cap_in_gb                 = 1
  daily_data_cap_notifications_enabled = true
  sampling_percentage                  = 100
  tags                                 = var.tags
}
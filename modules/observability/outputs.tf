output "log_analytics_workspace_id" {
    description = " Log analytics workspace ID"
    value = azurerm_log_analytics_workspace.main.id  
}

output "log_analytics_workspace_name" {
    description = "Log Analytics Workspace Name"
    value = azurerm_log_analytics_workspace.main.name
}

output "log_analytics_workspace_key" {
    description = "Primary Shared key "
    value = azurerm_log_analytics_workspace.main.primary_shared_key
    sensitive = true
}

output "application_insights_app_id" {
    description = "Application Insights ID"
    value = azurerm_application_insights.main.app_id  
}

output "application_insights_instrumentation_key" {
    description = "Application use it to send telemtry"
    value = azurerm_application_insights.main.instrumentation_key
    sensitive = true  
}

output "application_insights_connection_string" {
    description = "Application use it to send telemtry and prefereed way for apps"
    value = azurerm_application_insights.main.connection_string
    sensitive = true  
}
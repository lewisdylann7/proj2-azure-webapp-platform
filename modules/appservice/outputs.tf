# ============================================
# APP SERVICE MODULE - OUTPUTS
# ============================================

output "web_app_id" {
  description = "The Azure resource ID of the Web App"
  value       = azurerm_linux_web_app.main.id
}

output "web_app_name" {
  description = "The name of the Web App"
  value       = azurerm_linux_web_app.main.name
}

output "web_app_url" {
  description = <<-EOT
    The default URL of the Web App.
    Format: https://<name>.azurewebsites.net
  EOT
  value       = "[${azurerm_linux_web_app.main.default_hostname}](https://${azurerm_linux_web_app.main.default_hostname})"
}

output "web_app_principal_id" {
  description = <<-EOT
    The Principal ID of the Web App's Managed Identity.
    Use this to grant the web app access to other Azure resources.
  EOT
  value       = azurerm_linux_web_app.main.identity[0].principal_id
}

output "web_app_tenant_id" {
  description = "The Tenant ID of the Web App's Managed Identity"
  value       = azurerm_linux_web_app.main.identity[0].tenant_id
}

output "app_service_plan_id" {
  description = "The Azure resource ID of the App Service Plan"
  value       = azurerm_service_plan.main.id
}

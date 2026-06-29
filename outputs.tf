output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "web_app_url" {
  description = "Url of web app"
  value       = module.appservice.web_app_url
}

output "web_app_name" {
  description = "Name of web app"
  value       = module.appservice.web_app_name
}

output "sql_server_fqdn" {
  description = "Fully qualified name of the sql server"
  value       = module.database.sql_server_fqdn
}

output "sql_database_name" {
  description = "The name of the sql database"
  value       = module.database.sql_database_name
}

output "key_vault_uri" {
  description = "URI of key vault"
  value       = module.keyvault.key_vault_uri
}

output "application_insights_app_id" {
  description = "Application Inisghts appliction ID"
  value       = module.observability.application_insights_app_id
}

output "log_analytics_workspace_id" {
  description = "Lod analytics workspace resource ID"
  value       = module.observability.log_analytics_workspace_id
}

output "instructions" {
  description = "Post deployment instructions"
  value       = <<EOT
       ===============================
         DEPLOYMENT COMPLETE !
       ===============================  
       Web application available at : ${module.appservice.web_app_url}
       run "Terrafrom destroy" when done testing
    EOT  
}
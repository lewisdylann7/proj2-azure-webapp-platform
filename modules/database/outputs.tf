output "sql_server_id" {
    description = " SQL Server ID"
    value = azurerm_mssql_server.main.id  
}

output "sql_server_name" {
    description = "SQL Server Name" 
    value = azurerm_mssql_server.main.name 
}

output "sql_server_fqdn" {
    description = "Fully qualified name of SQL Server"
    value = azurerm_mssql_server.main.fully_qualified_domain_name  
}

output "sql_database_id" {
    description = "SQL DB ID"
    value = azurerm_mssql_database.main.id  
}

output "sql_database_name" {
    description = " SQL DB Name"
    value = azurerm_mssql_database.main.name  
}
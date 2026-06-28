locals {
  common_tags = {
    project = var.project_name
    environment = var.environment
    owner = var.owner
    managed_by = "terraform"
    architecture = "web-app-platform"
    deployed_date = timestamp()
  }

  name_prefix = "${var.project_name}-${var.environment}"


  sql_connection_string = join("",[
    "server=tcp:${var.sql_server_name}.database.windows.net,1433;",
    "Initial Catalog=${var.sql_database_name};",
    "Persist Security Info=False;",
    "User ID=${var.sql_admin_username};",
    "Password=${var.sql_admin_password};",
    "MultipleActiveResultSets=False;",
    "Encrypt=True;",
    "TrustServerCertificate=False;",
    "Connection Timeout=30;"
  ])
}
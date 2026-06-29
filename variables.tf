variable "project_name" {
  description = "Identifier for this project"
  type        = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9]{1,7}$", var.project_name))
    error_message = "Project name must be 2-8 and lower case"
  }
}

variable "environment" {
  description = "Environment identifier"
  type        = string
  validation {
    condition     = contains(["dev", "test", "uat", "prod"], var.environment)
    error_message = "Env must be one of: dev, test, uat or prod"
  }
}

variable "owner" {
  description = "Responsible for these resources"
  type        = string
}

variable "location" {
  description = "Region"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Azure resource group"
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of App service pln i.e: asp-project-environment"
  type        = string
}

variable "web_app_name" {
  description = "Name for the Web app has to be globally unique"
  type        = string
}

variable "sql_server_name" {
  description = " Has to be globally unique"
  type        = string
}

variable "sql_database_name" {
  description = "Name of sql db i.e: sqldb-project-environment"
  type        = string
}

variable "key_vault_name" {
  description = "Globally unique name 3-24"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]{2,23}$", var.key_vault_name))
    error_message = "Kv name must be 3-24 characters"
  }
}

variable "log_analytics_workspace_name" {
  description = "Name of Log Analytics workspace"
  type        = string
}

variable "application_insights_name" {
  description = "Name of Application Insights"
  type        = string
}

variable "sql_admin_username" {
  description = "Admin password must be 8 characters with uppercase lowercase number and chars"
  type        = string
  default     = "sqladminuser"
}

variable "sql_admin_password" {
  description = "Admin password with 8 characs uppercase lowercase numbers and cahrs"
  type        = string
  sensitive   = true
}
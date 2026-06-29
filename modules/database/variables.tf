variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Region"
  type        = string
}

variable "sql_server_name" {
  description = "Sql Server Name (Globally Unique)"
  type        = string
}

variable "sql_database_name" {
  description = "Sql Database Name"
  type        = string
}

variable "sql_admin_username" {
  description = " Sql db admin username"
  type        = string
}

variable "sql_admin_password" {
  description = "Sql db password"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
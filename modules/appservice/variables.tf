variable "resource_group_name" {
    description = "Resource Group Name"
    type = string  
}

variable "location" {
    description = "Region"
    type = string  
}

variable "app_service_plan_name" {
    description = "Name of App service plan"  
    type = string
}

variable "web_app_name" {
    description = "Globally unique name for web app"
    type = string  
}

variable "key_vault_id" {
    description = "Key vault ID"
    type = string  
}


variable "key_vault_uri" {
    description = "Key vault URI"
    type = string  
}

variable "application_insights_key" {
    description = "Instrumentation key for app insights"
    type = string  
}

variable "application_insights_connection_string" {
    description = "Connection string for application insights"
    type = string
    sensitive = true
}
variable "tags" {
    description = "tags"
    type = map(string)
    default = {}  
}
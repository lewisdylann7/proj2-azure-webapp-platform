variable "resource_group_name" {
    description = "Resource group name"
    type = string  
}

variable "location" {
    description = "Azure Region where log analytics is deployed"
    type = string  
}

variable "log_analytics_workspace_name" {
    description = "Name of workspace"
    type = string 
}

variable "application_insights_name" {
    description = "Name of workspace"
    type = string 
}

variable "tags" {
    description = "Tags"
    type = map(string)
    default = {}  
}
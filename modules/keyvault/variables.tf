variable "resource_group_name" {
    description = "Resource Group Name"
    type = string  
}

variable "location" {
    description = "Region"
    type = string  
}

variable "key_vault_name" {
    description = "Globally Unique Name"
    type = string  
}

variable "tenant_id" {
    description = "Azure AD tenant ID"
    type = string
}

variable "deployer_object_id" {
    description = "OBJECT ID of the service principal deploying resources"
    type = string  
}

variable "sql_connection_string" {
    description = "SQL Database conenction string to store a secret"
    type = string
    sensitive = true  
}

variable "tags" {
    description = "Tags"
    type = map(string)
    default ={}  
}
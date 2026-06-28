resource "azurerm_service_plan" "main" {
    name = var.app_service_plan_name
    location = var.location
    resource_group_name = var.resource_group_name
    sku_name = "B1"
    os_type = "Linux"
    #Zone balancing not available for basic tier
    zone_balancing_enabled = false
    tags = var.tags
}

resource "azurerm_linux_web_app" "main" {
    name = var.web_app_name
    location = var.location
    resource_group_name = var.resource_group_name
    service_plan_id = azurerm_service_plan.main.id
    https_only = true
    site_config {
        #Keep the app always loaded not \\\(not available on free and shared tiers)
        always_on = true

        application_stack {
          node_version = "20-lts"
        }

        minimum_tls_version = 1.2

        http2_enabled = true

        ftps_state = "Disabled"
    }  

    app_settings = {
        #Application Inisghts config
        "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.application_insights_connection_string
        "APPINSIGHTS_INSTRUMENTATIONKEY" = var.application_insights_key
        "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
        "KEY_VAULT_URI" = var.key_vault_uri
        "WEBSITE_NODE_DEFAULT_VERSION" = "~20"
    }

    #Enable Managed Identiyt
    identity {
      type = "SystemAssigned"
    }

    logs {
      application_logs {
        file_system_level = "Information"
      }

      http_logs {
        file_system {
          retention_in_days = 7
          retention_in_mb = 35
        }
      }

      detailed_error_messages = true

      failed_request_tracing = true
    }

    tags = var.tags
}
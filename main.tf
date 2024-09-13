resource "azurerm_resource_group" "az_diag_test" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_log_analytics_workspace" "tf_diag" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "PerGB2018"
}

resource "azurerm_key_vault" "kv" {
  name                = "azurekv80"
  location            = azurerm_resource_group.az_diag_test.location
  resource_group_name = azurerm_resource_group.az_diag_test.name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id

}

# resource "azurerm_monitor_diagnostic_setting" "without_metrics" {
#   name                           = "diag-setting-without-metric"
#   target_resource_id             = azurerm_key_vault.kv.id
#   log_analytics_workspace_id     = azurerm_log_analytics_workspace.tf_diag.id
#   log_analytics_destination_type = "Dedicated"


#   dynamic "enabled_log" {
#     for_each = ["AuditEvent"]
#     content {
#       category = enabled_log.value
#     }
#   }
# }

resource "azurerm_monitor_diagnostic_setting" "with_metrics" {
  name                           = "diag-setting-with-metric"
  target_resource_id             = azurerm_key_vault.kv.id
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.tf_diag.id
  log_analytics_destination_type = "Dedicated"


  dynamic "enabled_log" {
    for_each = ["AuditEvent"]
    content {
      category = enabled_log.value
    }
  }


  dynamic "metric" {
    for_each = ["AllMetrics"]
    content {
      category = metric.value
      enabled  = true

      # retention_policy {
      #   enabled = true
      #   days    = 30
      # }
    }
  }
}

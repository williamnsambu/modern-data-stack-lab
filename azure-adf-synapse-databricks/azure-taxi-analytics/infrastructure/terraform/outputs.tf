output "eventhub_namespace" {
  value = azurerm_eventhub_namespace.eh_namespace.name
}

output "eventhub_name" {
  value = azurerm_eventhub.eh_stream.name
}

output "storage_account" {
  value = azurerm_storage_account.data_lake.name
}

output "primarykey" {
  value = azurerm_storage_account.mystorage.primary_access_key
  sensitive = true
}

output "primaryblobhost" {
  value = azurerm_storage_account.mystorage.primary_blob_host  
}
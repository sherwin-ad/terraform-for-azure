output "primarykey" {
  value = values(azurerm_storage_account.mystorage)[0].primary_access_key
  sensitive = true
}

output "primaryblobhost" {
  value = values(azurerm_storage_account.mystorage)[1].primary_blob_host  
}
resource "azurerm_resource_group" "example" {
  name     = "example"
  location = var.azregion
}

resource "azurerm_storage_account" "mystorage" {
  name                     = "owenteststorage001"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = var.accesstier
  account_replication_type = var.replicationtype

  tags = {
    environment = "staging"
    owner = "Mr. ${local.name}"
  }
}

output "primarykey" {
  value = azurerm_storage_account.mystorage.primary_access_key
  sensitive = true
}
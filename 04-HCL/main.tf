resource "azurerm_resource_group" "example" {
  name     = "example"
  location = var.azregion
}
/*resource "azurerm_storage_account" "mystorage" {
  count = 2
  name                     = "owenteststorage00${count.index}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
    owner = "Mr. ${local.name}"
  }*/

resource "azurerm_storage_account" "mystorage" {
  for_each = {
    lrs = "LRS"
    grs = "GRS"
  }
  name                     = "owenteststorage${each.key}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = each.value

  tags = {
    environment = "staging"
    owner = "Mr. ${local.name}"
  }  
}


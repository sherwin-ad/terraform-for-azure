data "azurerm_resource_group" "NewRG" {
  name = "example-rg"
}
resource "azurerm_storage_account" "mystorage" {
  name                     = "owenteststorage001"
  resource_group_name      = data.azurerm_resource_group.NewRG.name
  location                 = data.azurerm_resource_group.NewRG.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  tags = {
    environment = "staging"
    owner = "Sherwin"
  }
}
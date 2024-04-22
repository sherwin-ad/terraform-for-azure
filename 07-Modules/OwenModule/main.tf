resource "azurerm_resource_group" "example" {
  name     = "example"
  location = var.azregion
}

resource "azurerm_storage_account" "mystorage" {
  name                     = var.storagename
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = var.accesstier
  account_replication_type = var.replicationtype

  tags = {
    environment = "staging"
    owner = "Mr. ${local.name}"
  }
}

resource "azurerm_network_security_group" "example" {
  name                = "example-security-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

}

output "primarykey" {
  value = azurerm_storage_account.mystorage.primary_access_key
  sensitive = true
}
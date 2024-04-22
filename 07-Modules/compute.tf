data "azurerm_subnet" "subnet" {
  resource_group_name = "example"
  name = "subnet1"
  virtual_network_name = "example-network"
}

module "compute" {
  source  = "Azure/compute/azurerm"
  version = "5.3.0"
  # insert the 2 required variables here
   resource_group_name = "example"
   vnet_subnet_id = data.azurerm_subnet.subnet.id
   is_windows_image = true
   vm_os_simple = "WindowsServer"
   availability_set_enabled = false
   admin_username = "owenadmin"
   admin_password = "[Abcd@1234]"
}


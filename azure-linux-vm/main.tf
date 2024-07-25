# Create Resource Group
resource "azurerm_resource_group" "busybee-rg" {
  name     = "busybee-rg"
  location = "West Europe"
}

# Create Virtual Network
resource "azurerm_virtual_network" "busybee-rg" {
  name                = "busybee-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.busybee-rg.location
  resource_group_name = azurerm_resource_group.busybee-rg.name
}

# Create Subnet
resource "azurerm_subnet" "busybee-rg" {
  name                 = "busybee-subnet"
  resource_group_name  = azurerm_resource_group.busybee-rg.name
  virtual_network_name = azurerm_virtual_network.busybee-rg.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Public IP
resource "azurerm_public_ip" "busybee-public-ip" {
  name                = "vm_public_ip"
  resource_group_name = azurerm_resource_group.busybee-rg.name
  location            = azurerm_resource_group.busybee-rg.location
  allocation_method   = "Dynamic"
}

# Network Interface
resource "azurerm_network_interface" "busybee-nic" {
  name                = "busybee-nic"
  location            = azurerm_resource_group.busybee-rg.location
  resource_group_name = azurerm_resource_group.busybee-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.busybee-rg.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.busybee-public-ip.id
  }
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = "ssh_nsg"
  location            = azurerm_resource_group.busybee-rg.location
  resource_group_name = azurerm_resource_group.busybee-rg.name

  security_rule {
    name                       = "allow_ssh_sg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate NSG with interface
resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.busybee-nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create Virtual Machine
resource "azurerm_linux_virtual_machine" "busybee-rg" {
  name                = "busybee-rg-machine"
  resource_group_name = azurerm_resource_group.busybee-rg.name
  location            = azurerm_resource_group.busybee-rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.busybee-nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

# Output
output "public_ip" {
  value = azurerm_public_ip.busybee-public-ip.ip_address
}
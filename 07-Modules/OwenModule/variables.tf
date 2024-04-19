variable "azregion" {
  type = string
  description = "This is the Azure Region"
  default = "EastUs"
}

variable "storagename" {
  type = string
  description = "This is the Azure Storage Name"
  default = "owenstorageacc001"
}

variable "accesstier" {
  type = string
  description = "This is the Azure Access Tier"
  default = "Standard"
}

variable "replicationtype" {
  type = string
  description = "This is the Azure Storage Replication Type"
  default = "LRS"
}
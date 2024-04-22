variable "azregion" {
    type = string
    description = "This is the Azure Region"
    default = "EastUS"   
}

variable "storagename" {
    type = string
    description = "This is the Azure Storage"
    default = "owenstorageacc001"   
}

variable "accesstier" {
    type = string
    description = "This is the Azure Storage access tier"
    default = "Standard"   
}

variable "replicationtype" {
    type = string
    description = "This is the Azure Storage replication type"
    default = "LRS"   
}


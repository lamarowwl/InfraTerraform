terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
}

provider "azurerm" {
  
  features {}
  subscription_id = var.subscription_id
}

variable "location" {
  type        = string
  default     = "West Europe"
  description = "Região onde os dados serão criados"
}

variable "resource_group_name" {
  type        = string
  description = "Nome do grupo de recursos"
}

variable "admin_password" {
  type        = string
  sensitive     = true
  description = "Senha de admin da VM"
}

variable "subscription_id" {
  description = "ID da assinatura do Azure"
  type        = string
}

resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {

  name = "vnet-demo"
  address_space = ["10.0.0.0/16"]
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {

  name = "subnet-demo"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes =["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {

  name = "nic-demo"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {

    name = "internal"
    subnet_id  = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {

  name  = "lucas-vm"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  size = "Standard_B1s"
  admin_username = "azureuser"
  network_interface_ids = [azurerm_network_interface.nic.id]
  disable_password_authentication = false
  admin_password  = var.admin_password

  os_disk {

    caching  = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name  = "osdisk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "18.04-LTS"
    version = "latest"
  }
}
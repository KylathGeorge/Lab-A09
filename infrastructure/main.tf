# 1. The Terraform Configuration Block
terraform {
  required_version = ">= 1.2.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # This locks it to version 3.x, satisfying TFLint
    }
  }
}

# 2. Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# 3. Your Resources
resource "azurerm_resource_group" "hybrida09" {
  name     = "rg-hybrida09"
  location = "Canada Central"
}

resource "azurerm_storage_account" "test_storage" {
  name                     = "sthybrida09test"
  resource_group_name      = azurerm_resource_group.hybrida09.name
  location                 = azurerm_resource_group.hybrida09.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
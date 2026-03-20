# infrastructure/main.tf

resource "azurerm_resource_group" "hybrida09" {
  name     = "rg-hybrida09"
  location = "Canada Central"
}

resource "azurerm_storage_account" "test_storage" {
  name                     = "sthybrida09test" # Must be unique globally
  resource_group_name      = azurerm_resource_group.hybrida09.name
  location                 = azurerm_resource_group.hybrida09.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
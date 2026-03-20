terraform {
  required_version = ">= 1.2.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "hybrida09" {
  name     = "rg-hybrida09"
  location = "Canada Central"
}

resource "azurerm_kubernetes_cluster" "app" {
  name                = "aks-hybrida09"
  location            = azurerm_resource_group.hybrida09.location
  resource_group_name = azurerm_resource_group.hybrida09.name
  dns_prefix          = "aks-hybrida09"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_B2s"
    auto_scaling_enabled = true
    min_count           = 1
    max_count           = 3
  }

  identity {
    type = "SystemAssigned"
  }
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.app.kube_config_raw
  sensitive = true
}
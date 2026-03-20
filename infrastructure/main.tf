# 1. Required Terraform & Provider Configuration
# This fixes the TFLint "Missing version constraint" warnings
terraform {
  required_version = ">= 1.2.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" 
    }
  }
}

provider "azurerm" {
  features {}
}

# 2. Resource Group
resource "azurerm_resource_group" "hybrida09" {
  name     = "rg-hybrida09"
  location = "Canada Central"
}

# 3. Azure Kubernetes Service (AKS) Cluster
resource "azurerm_kubernetes_cluster" "app" {
  name                = "aks-hybrida09"
  location            = azurerm_resource_group.hybrida09.location
  resource_group_name = azurerm_resource_group.hybrida09.name
  dns_prefix          = "aks-hybrida09"
  kubernetes_version  = "1.30" # Recommended: Use a recent stable version

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_B2s"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

# 4. Output for Kubeconfig (Required for connection)
output "kube_config" {
  value     = azurerm_kubernetes_cluster.app.kube_config_raw
  sensitive = true
}
terraform {
  required_version = ">= 1.1.0"
  requried_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.14.0"
    }
  }
  cloud {
    organization = "upskilljana"
    workspaces {
      name = "AZWorkspaceTF"
    }
  }
}
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
#  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
  name     = "ecommercesurge-rg"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "ecommercesurge-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "ecommercesurge-aks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "development"
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

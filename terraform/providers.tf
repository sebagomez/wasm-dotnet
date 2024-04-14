terraform {
  required_version = ">=1.0"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id   = var.subscriptionid
  tenant_id         = var.tennantid
  client_id         = var.clientid
  client_secret     = var.clientsecret
}

variable "subscriptionid"{
    type = string
}

variable "tennantid"{
    type = string
}

variable "clientid"{
    type = string
}

variable "clientsecret"{
    type = string
}
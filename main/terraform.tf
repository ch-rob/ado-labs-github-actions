##################################################################################
# TERRAFORM CONFIG
##################################################################################
terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 2.0"
        }
    }
    backend "azurerm" {
        resource_group_name  = "githublab-37853"
        storage_account_name = "githublab37853"
        container_name       = "terraform-state"        
        key = "app.terraform.tfstate"
    }
}


##################################################################################
# PROVIDERS
##################################################################################

provider "azurerm" {
  features {}
}
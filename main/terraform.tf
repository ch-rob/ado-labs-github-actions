##################################################################################
# TERRAFORM CONFIG
##################################################################################
terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 4.19"
        }
        azapi = {
            source  = "Azure/azapi"
            version = "~> 2.2"
        }
    }
    backend "azurerm" {
        resource_group_name  = "githublab-37853"
        storage_account_name = "githublab37853"
        container_name       = "terraform-state"        
        key                  = "app.terraform.tfstate"
    }
}


##################################################################################
# PROVIDERS
##################################################################################

provider "azurerm" {
    features {}
    subscription_id      = "1ab5dc89-603c-4f45-bdd1-a4231369b400"
}
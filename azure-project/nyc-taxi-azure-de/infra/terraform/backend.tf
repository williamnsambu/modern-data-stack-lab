terraform {
  backend "azurerm" {
    resource_group_name  = "rg-portfolio"
    storage_account_name = "assportfolio"
    container_name       = "tfstate"
    key                  = "nyc-taxi/dev.tfstate"
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.30.0"
    }
  }

  backend "azurerm" {
    use_azuread_auth     = true
    tenant_id            = "e11839fb-0867-429f-a1a9-c4c627d2e205"
    subscription_id      = "2fd30c47-5c76-4121-8b39-6dc5938696b9"
    resource_group_name  = "custom_role_test"
    storage_account_name = "customrolesta"
    container_name       = "customroleblob"
    key                  = "CUSTOMROLES/<<< FILE NAME (without .tf)>>>.tfstate"
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}

# Import command:
# terraform import module.custom_role.azurerm_role_definition.role[`"Suncor`"] "/subscriptions/1399782e-5c68-48d7-9af5-80d3f34887c5/providers/Microsoft.Authorization/roleDefinitions/34e329a0-18e8-4927-897b-45372443b66f|/providers/Microsoft.Management/managementGroups/Suncor"

module "custom_role" {
  source = "git::https://github.com/majazbaig/cloudmodules/blob/main/azurerm/custom_role/main.tf"

  environment = "test" # <<< non-prd >>> or <<< prd >>>
  name        = "<<< NAME >>>"
  description = "<<< DESCRIPTION >>>"

  actions = [
    "action1",
    "action2"
  ]

  not_actions      = []
  data_actions     = []
  not_data_actions = []
}

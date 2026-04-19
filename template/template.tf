terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.30.0"
    }
  }

  backend "azurerm" {
    use_azuread_auth     = true
    tenant_id            = "1aa51068-11a6-4bd2-8646-1fff31a30ffc"
    subscription_id      = "c415313f-fb5a-4e67-a8dc-be4e0998a358"
    resource_group_name  = "iacprdarmrgp003"
    storage_account_name = "iacprdarmstauw2003"
    container_name       = "iacprdarmstbuw2003"
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
  source = "git::https://github.com/SEApplicationsOrg/cca-terraform-cloud-modules.git//modules/azurerm/custom_role?ref=main"

  environment = "non-prd" # <<< non-prd >>> or <<< prd >>>
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

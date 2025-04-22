module "log_analytics_workspace" {
  source  = "Azure/avm-res-operationalinsights-workspace/azurerm"
  # https://registry.terraform.io/modules/Azure/avm-res-operationalinsights-workspace/azurerm/latest
  version = "0.4.2"

  name                = local.resource_names.log_analytics_workspace_name
  location            = var.location
  resource_group_name = module.resource_group.name
}

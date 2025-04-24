module "key_vault" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "0.9.1"

  name                          = local.resource_names.key_vault_name
  location                      = var.location
  resource_group_name           = module.resource_group.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled = true

  private_endpoints = {
    primary = {
      private_dns_zone_resource_ids = [module.private_dns_zone_key_vault.resource_id]
      subnet_resource_id            = module.virtual_network.subnets["private_endpoints"].resource_id
      subresource_name              = ["vault"]
      tags                          = var.tags
    }
  }

  wait_for_rbac_before_key_operations = {
    create = "60s"
  }

  network_acls = {
    bypass   = "AzureServices"
    ip_rules = [local.my_cidr_slash_24]    # Add for external IP address access
  }

  diagnostic_settings = local.diagnostic_settings
  tags                = var.tags
}

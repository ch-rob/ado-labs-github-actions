# Calculate resource names
locals {
  name_replacements = {
    prefix          = var.naming_prefix
    prefix_no_dash  = replace(var.naming_prefix, "-", "")
    workload        = var.resource_name_workload
    environment     = var.resource_name_environment
    location        = var.location
  }

  resource_names = { for key, value in var.resource_name_templates : key => templatestring(value, local.name_replacements) }

    # Calculate the CIDR for the subnets
  subnets = { for key, value in var.subnets : key => {
    name             = key
    address_prefixes = [module.avm-utl-network-ip-addresses.address_prefixes[key]]
    network_security_group = value.has_network_security_group ? {
      id = module.network_security_group.resource_id
    } : null
    nat_gateway = value.has_nat_gateway ? {
      id = module.nat_gateway.resource_id
    } : null
    }
  }

  diagnostic_settings = {
    sendToLogAnalytics = {
      name                  = "sendToLogAnalytics"
      workspace_resource_id = module.log_analytics_workspace.resource.id
    }
  }
}

# My IP address
locals {
  my_ip_address_split = split(".", data.http.ip.response_body)
  my_cidr_slash_24    = "${join(".", slice(local.my_ip_address_split, 0, 3))}.0/24"
}
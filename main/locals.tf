# Calculate resource names
locals {
  name_replacements = {
    prefix      = var.naming_prefix
    workload    = var.resource_name_workload
    environment = var.resource_name_environment
    location    = var.location
  }

  resource_names = { for key, value in var.resource_name_templates : key => templatestring(value, local.name_replacements) }
}

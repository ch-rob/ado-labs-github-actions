variable "location" {
  type    = string
  default = "canadacentral"
}

variable "naming_prefix" {
  type    = string
  default = "crv-githublab"
}

variable "asp_tier" {
    type = string
    description = "Tier for App Service Plan (Standard, PremiumV2)"
    default = "Free"
}

variable "asp_size" {
    type = string
    description = "Size for App Service Plan (S2, P1v2)"
    default = "S1"
}

variable "capacity" {
  type = string
  description = "Number of instances for App Service Plan"
  default = "1"
}

variable "resource_name_workload" {
  type        = string
  description = "The name segment for the workload"
  default     = "demo"
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.resource_name_workload))
    error_message = "The name segment for the workload must only contain lowercase letters and numbers."
  }
  validation {
    condition     = length(var.resource_name_workload) <= 4
    error_message = "The name segment for the workload must be 4 characters or less."
  }
}

variable "resource_name_environment" {
  type        = string
  description = "The name segment for the environment"
  default     = "dev"
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.resource_name_environment))
    error_message = "The name segment for the environment must only contain lowercase letters and numbers."
  }
  validation {
    condition     = length(var.resource_name_environment) <= 4
    error_message = "The name segment for the environment must be 4 characters or less."
  }
}

variable "address_space" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The address space that is used in the virtual network"
}

variable "subnets" {
  type = map(object({
    size                       = number
    has_nat_gateway            = bool
    has_network_security_group = bool
  }))
  description = "The subnets"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}

variable "enable_encryption_at_host" {
  type        = bool
  description = "Enable encryption at host"
  default     = false
}

variable "resource_name_templates" {
  type        = map(string)
  description = "A map of resource names to use"
  default = {
    resource_group_name                 = "rg-$${prefix}-$${workload}-$${environment}"
    log_analytics_workspace_name        = "law-$${prefix}-$${workload}-$${environment}"
    virtual_network_name                = "vnet-$${prefix}-$${workload}-$${environment}"
    network_security_group_name         = "nsg-$${prefix}-$${workload}-$${environment}"
    nat_gateway_name                    = "nat-$${prefix}-$${workload}-$${environment}"
    nat_gateway_public_ip_name          = "pip-nat-$${prefix}-$${workload}-$${environment}"    
    key_vault_name                      = "kv$${prefix}$${workload}$${environment}"
    storage_account_name                = "sa$${prefix_no_dash}$${workload}$${environment}"
    user_assigned_managed_identity_name = "uami-$${prefix}-$${workload}-$${environment}"
    virtual_machine_name                = "vm-$${prefix}-$${workload}-$${environment}"
    network_interface_name              = "nic-$${prefix}-$${workload}-$${environment}"
    bastion_host_public_ip_name         = "pip--$${prefix}bas-$${workload}-$${environment}"
    bastion_host_name                   = "bas-$${prefix}-$${workload}-$${environment}"

  }
}

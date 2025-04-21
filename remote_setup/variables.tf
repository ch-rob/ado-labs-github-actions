#############################################################################
# VARIABLES
#############################################################################

variable "location" {
  type    = string
  default = "canadacentral"
}

variable "naming_prefix" {
  type    = string
  default = "githublab"
}

variable "github_repository" {
  type    = string
  default = "ado-labs-github-actions"
}
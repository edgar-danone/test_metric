variable "resource_group_name" {
  type        = string
  description = "The rg name"
}

variable "location" {
  type    = string
  default = "The resources location"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Log analytics workspace name"
}
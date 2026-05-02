variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "S0"
}

variable "kind" {
  type    = string
  default = "AIServices"
}

variable "custom_subdomain_name" {
  type = string
}

variable "dynamic_throttling_enabled" {
  type    = bool
  default = false
}

variable "local_auth_enabled" {
  type    = bool
  default = true
}

variable "outbound_network_access_restricted" {
  type    = bool
  default = false
}

variable "public_network_access_enabled" {
  type    = bool
  default = true
}

variable "project_management_enabled" {
  type    = bool
  default = false
}

variable "account_identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "rai_policies" {
  type = map(object({
    name             = string
    base_policy_name = string
    mode             = optional(string)
    content_filters = list(object({
      name               = string
      filter_enabled     = bool
      block_enabled      = bool
      severity_threshold = string
      source             = string
    }))
  }))
  default = {}
}

variable "cognitive_deployments" {
  type = map(object({
    name                       = string
    rai_policy_name            = optional(string)
    version_upgrade_option     = optional(string, "OnceNewDefaultVersionAvailable")
    dynamic_throttling_enabled = optional(bool, false)
    model = object({
      format  = string
      name    = string
      version = optional(string)
    })
    sku = object({
      name     = string
      capacity = optional(number)
      family   = optional(string)
      size     = optional(string)
      tier     = optional(string)
    })
  }))
  default = {}
}

variable "projects" {
  type = map(object({
    name         = string
    location     = string
    description  = optional(string)
    display_name = optional(string)
    identity = object({
      type         = string
      identity_ids = optional(list(string), [])
    })
    tags = optional(map(string), {})
  }))
  default = {}

  validation {
    condition     = length(var.projects) == 0 || var.project_management_enabled
    error_message = "project_management_enabled must be true when projects are configured."
  }
}

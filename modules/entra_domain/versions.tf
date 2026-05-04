terraform {
  required_version = ">= 1.6.0"

  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.2.0"
    }
  }
}

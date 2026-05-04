locals {
  domain_resource_url = var.create ? msgraph_resource.domain[0].resource_url : "domains/${var.domain_name}"
}

resource "msgraph_resource" "domain" {
  count = var.create ? 1 : 0

  url = "domains"
  body = {
    id = var.domain_name
  }

  response_export_values = {
    id          = "id"
    is_verified = "isVerified"
    all         = "@"
  }
}

data "msgraph_resource" "domain" {
  url = local.domain_resource_url

  response_export_values = {
    id          = "id"
    is_initial  = "isInitial"
    is_verified = "isVerified"
    all         = "@"
  }
}

data "msgraph_resource" "verification_dns_records" {
  url = "domains/${var.domain_name}/verificationDnsRecords"

  response_export_values = {
    records = "value"
    all     = "@"
  }

  depends_on = [msgraph_resource.domain]
}

resource "msgraph_resource_action" "verify" {
  count = var.verify ? 1 : 0

  resource_url = local.domain_resource_url
  action       = "verify"
  method       = "POST"

  depends_on = [data.msgraph_resource.verification_dns_records]
}

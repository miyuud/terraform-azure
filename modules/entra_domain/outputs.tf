output "domain_id" {
  value = data.msgraph_resource.domain.output.id
}

output "is_verified" {
  value = data.msgraph_resource.domain.output.is_verified
}

output "verification_dns_records" {
  value = data.msgraph_resource.verification_dns_records.output.records
}

output "domain" {
  value = data.msgraph_resource.domain.output.all
}

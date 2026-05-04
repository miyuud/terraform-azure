# entra_domain

Tenant-level Entra custom domain management.

## Purpose
Create a tenant domain and optionally trigger domain verification.

## Inputs
- `domain_name`: domain to manage (for example `chechia.net`).
- `create`: whether to create the domain if it does not already exist. Default `false`.
- `verify`: whether to run Graph `verify` action. Default `false`.

## Outputs
- `domain_id`
- `is_verified`
- `verification_dns_records`
- `domain`

## Suggested flow
1. Apply with `create = true` and `verify = false` to create domain and output DNS verification records.
2. Configure the required DNS TXT/MX records.
3. Apply again with `verify = true` after DNS propagation.

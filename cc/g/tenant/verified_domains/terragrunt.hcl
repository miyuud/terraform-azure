terraform {
  source = "${get_repo_root()}/modules/entra_domain"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  domain_name = "chechia.net"
  create      = false
  verify      = true
}

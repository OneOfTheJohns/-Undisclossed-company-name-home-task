include "region" {
  path = find_in_parent_folders("region.hcl")
  expose = true
}

include "account" {
  path = find_in_parent_folders("account.hcl")
  expose = true
}

terraform {
    source = "../../../../terraform-modules/github_IdP"
}

# example inputs
inputs = {
}
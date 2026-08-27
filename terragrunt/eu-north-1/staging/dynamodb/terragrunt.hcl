include "region" {
  path = find_in_parent_folders("region.hcl")
  expose = true
}

include "account" {
  path = find_in_parent_folders("account.hcl")
  expose = true
}

terraform {
    source = "../../../../terraform-modules/dynamodb"
}

# example inputs
inputs = {
  table_name = "stg-table"
}
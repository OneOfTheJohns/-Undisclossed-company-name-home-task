include "region" {
  path = find_in_parent_folders("region.hcl")
  expose = true
}

# https://docs.terragrunt.com/features/units/state-backend/
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "my-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = include.region.locals.region
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
}
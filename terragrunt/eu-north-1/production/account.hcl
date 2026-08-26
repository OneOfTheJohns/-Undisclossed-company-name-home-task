locals {
  account_id = "432998432364"
}

# https://docs.terragrunt.com/features/units/state-backend/
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {
    bucket         = "terraform-state-s3-bucket-very-original"
    key            = "${path_relative_to_include()}/tofu.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    use_lockfile = true
  }
}
EOF
}
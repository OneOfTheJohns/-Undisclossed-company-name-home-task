include "region" {
  path = find_in_parent_folders("region.hcl")
  expose = true
}

include "account" {
  path = find_in_parent_folders("account.hcl")
  expose = true
}

terraform {
  source = "../../../../terraform-modules/iam"
}

locals {
}
# example inputs
inputs = {
  role_name = "lambda_role_stg"
  account_id = include.account.locals.account_id
  policy_json = file("./policy.json")
  assume_role_policy = templatefile("./assume_role_policy.json", {
  })
}

# https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/permissions-reference-cwl.html
# https://docs.aws.amazon.com/service-authorization/latest/reference/list_apigatewayv2.html
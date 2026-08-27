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
  user_name = "john"
}
# example inputs
inputs = {
  role_name = "lambda_role_prod"
  account_id = include.account.locals.account_id
  user_name = local.user_name
  policy_json = file("./policy.json")
  assume_role_policy = templatefile("./policy.json", {
    account_id = include.account.locals.account_id
    user_name  = local.user_name
  })
}

# https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/permissions-reference-cwl.html
# https://docs.aws.amazon.com/service-authorization/latest/reference/list_apigatewayv2.html
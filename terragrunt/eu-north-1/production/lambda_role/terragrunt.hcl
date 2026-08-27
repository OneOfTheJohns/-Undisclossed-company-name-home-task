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

# example inputs
inputs = {
  role_name = "lambda_role_prod"
  account_id = include.account.locals.account_id
  user_name = "john"
  policy_json = file("./policy.json")
  assume_role_policy = templatefile("${path.module}/policy.json.tpl", {
    account_id = var.account_id
    user_name  = var.user_name
  })
}

# https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/permissions-reference-cwl.html
# https://docs.aws.amazon.com/service-authorization/latest/reference/list_apigatewayv2.html
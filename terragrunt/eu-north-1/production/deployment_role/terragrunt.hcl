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
  role_name = "deployment-role"
  account_id = include.account.locals.account_id
  env = "prod"
  user_name = "john"
  policy_json = file("./policy.json")
  ### https://medium.com/@kroeze.wb/secure-github-deployments-to-aws-with-oidc-aa4203a523cc
  ### Adding a assume_role_policy for OIDC wiht github actions.
  assume_role_policy = templatefile("./assume_role_policy.json", {
    account_id = include.account.locals.account_id
    path = "repo:OneOfTheJohns@80323322/-Undisclossed-company-name-home-task@1345081728*"
  })
}

# https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/permissions-reference-cwl.html
# https://docs.aws.amazon.com/service-authorization/latest/reference/list_apigatewayv2.html
# https://docs.aws.amazon.com/aws-managed-policy/latest/reference/AWSLambdaBasicExecutionRole.html

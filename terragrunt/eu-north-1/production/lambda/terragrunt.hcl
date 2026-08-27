include "region" {
  path = find_in_parent_folders("region.hcl")
  expose = true
}

include "account" {
  path = find_in_parent_folders("account.hcl")
  expose = true
}

terraform {
  source = "../../../../terraform-modules/lambda"
}

dependency "lambda_role" {
  config_path = "../lambda_role"
  mock_outputs = {
    role_arn = "arn:aws:iam::123456789012:role/mock-lambda-role"
  }
}

dependency "dynamodb" {
  config_path = "../dynamodb"
  mock_outputs = {
    table_name = "mock_output_table_name"
  }
}

inputs = {
  path_to_lambda = "../../../lambdas/apigw_processing/deployment_package.zip"
  lambda_iam_role_arn = dependency.lambda_role.outputs.role_arn
  env_variables = {
    table_name = dependency.dynamodb.outputs.table_name 
  }
}
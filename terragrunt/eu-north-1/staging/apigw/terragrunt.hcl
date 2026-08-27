include "region" {
  path = find_in_parent_folders("region.hcl")
  expose = true
}

include "account" {
  path = find_in_parent_folders("account.hcl")
  expose = true
}

terraform {
  source = "../../../../terraform-modules/apigw"
}

dependency "lambda" {
  config_path = "../lambda"
  mock_outputs = {
    lambda_arn = "lambda_arn_mock_output"
    function_name = "function_name"
  }
}

inputs = {
  apigw_name = "stggw"
  throttling_burst_limit = 500
  throttling_rate_limit = 500
  integration_uri = dependency.lambda.outputs.lambda_arn
  function_name = dependency.lambda.outputs.function_name
}
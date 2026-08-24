terraform {
    source = "../../terraform-modules/apigw"
}

dependency "lambda" {
    config_path = "../lambda"
}

inputs = {
    apigw_name = "prodgw"
    throttling_burst_limit = 500
    throttling_rate_limit = 500
    integration_uri = dependency.lambda.output.lambda_arn
}
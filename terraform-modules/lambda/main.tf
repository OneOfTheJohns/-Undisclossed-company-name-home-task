# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function.html

# Lambda function
resource "aws_lambda_function" "example" {
  filename      = var.path_to_lambda
  function_name = "apigw_request_process_lambda"
  role          = var.lambda_iam_role_arn
  handler = "main.lambda_handler"
  source_code_hash = filebase64sha256(var.path_to_lambda)

  runtime = "python3.12"

  environment {
    variables = var.env_variables
  }
}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function.html

resource "aws_iam_role" "example" {
  name               = "lambda_execution_role"
  assume_role_policy = var.lambda_iam_role_policy
}

# Lambda function
resource "aws_lambda_function" "example" {
  filename      = var.path_to_lambda
  function_name = "apigw_request_process_lambda"
  role          = aws_iam_role.example.arn
  handler       = "index.handler"

  runtime = "python3.12"

  environment {
    variables = {
      ENVIRONMENT = "production"
      LOG_LEVEL   = "info"
    }
  }
}
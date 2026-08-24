### https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api
resource "aws_apigatewayv2_api" "example" {
  name          = var.apigw_name
  protocol_type = var.protocol_type
}

### https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage.html
resource "aws_apigatewayv2_stage" "example" {
  api_id = aws_apigatewayv2_api.example.id
  name   = "stage-${var.apigw_name}"
  default_route_settings {
    throttling_rate_limit = var.throttling_rate_limit
    throttling_burst_limit = var.throttling_burst_limit 
  }
}

### https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_route
resource "aws_apigatewayv2_route" "health-POST" {
  count = length(var.route_keys)
  api_id    = aws_apigatewayv2_api.api.id
  route_key = var.route_keys[count.index]
  target    = "integrations/${var.aws_apigatewayv2_integration.creating_integration.id}"
  depends_on = [ aws_apigatewayv2_integration.creating_integration ]
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_integration
resource "aws_apigatewayv2_integration" "creating_integration" {
  count = var.integration_uri ? 1 : 0
  api_id           = aws_apigatewayv2_api.example.id
  integration_type = var.integration_type
  connection_type           = var.connection_type
  content_handling_strategy = var.content_handling_strategy
  description               = var.description
  integration_method        = var.integration_method
  integration_uri           = var.integration_uri
  passthrough_behavior      = var.passthrough_behavior
}
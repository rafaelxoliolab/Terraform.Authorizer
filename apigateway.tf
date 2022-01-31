resource "aws_api_gateway_rest_api" "ApiGateway" {
  name        = var.api_name
  description = var.api_description
}

resource "aws_api_gateway_resource" "api_dotnet" {
  rest_api_id = aws_api_gateway_rest_api.ApiGateway.id
  parent_id   = aws_api_gateway_rest_api.ApiGateway.root_resource_id
  path_part   = "{proxy+}"

  depends_on = [
    aws_api_gateway_rest_api.ApiGateway
  ]
}

resource "aws_api_gateway_method" "ApiDotNetMethod" {
  rest_api_id        = aws_api_gateway_rest_api.ApiGateway.id
  resource_id        = aws_api_gateway_resource.api_dotnet.id
  http_method        = "ANY"
  authorization      = "CUSTOM"
  authorizer_id = module.aws_auth_function.authorizer_id
  request_parameters = { "method.request.path.proxy" = true }

  depends_on = [
    aws_api_gateway_resource.api_dotnet
  ]
}

resource "aws_api_gateway_integration" "MyDemoIntegration" {
  rest_api_id          = aws_api_gateway_rest_api.ApiGateway.id
  resource_id          = aws_api_gateway_resource.api_dotnet.id
  http_method          = aws_api_gateway_method.ApiDotNetMethod.http_method
  type                 = "MOCK"
  timeout_milliseconds = 29000

  request_parameters = {
    "integration.request.header.X-Authorization" = "'static'"
  }

  # Transforms the incoming XML request to JSON
  request_templates = {
    "application/xml" = <<EOF
{
   "body" : $input.json('$')
}
EOF
  }
}

/*resource "aws_api_gateway_deployment" "ApiDeployment" {
  rest_api_id = aws_api_gateway_rest_api.ApiGateway.id
  stage_name  = var.stage_name
}*/
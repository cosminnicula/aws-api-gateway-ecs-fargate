resource "aws_api_gateway_rest_api" "main" {
  name = "${var.deployment}-api_gateway_rest_api-main"
}

resource "aws_api_gateway_resource" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "main" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.main.id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.main.id
  http_method = aws_api_gateway_method.main.http_method

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  type                    = "HTTP_PROXY"
  uri                     = "http://${var.lb_main_dns_name}:${var.microservice1_port}/{proxy}"
  integration_http_method = "ANY"

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.main.id
}

resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = var.environment
  depends_on  = [aws_api_gateway_integration.main]

  variables = {
    resources = join(", ", [aws_api_gateway_resource.main.id])
  }

  lifecycle {
    create_before_destroy = true
  }
}

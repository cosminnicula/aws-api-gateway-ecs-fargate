resource "aws_api_gateway_vpc_link" "main" {
  name        = "${var.deployment}-api_gateway_vpc_link-main"
  target_arns = [var.lb_main_arn]
}

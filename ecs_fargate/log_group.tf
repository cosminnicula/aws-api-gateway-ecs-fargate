resource "aws_cloudwatch_log_group" "main" {
  name = local.cloudwatch_log_group_main

  tags = {
    Name        = local.cloudwatch_log_group_main
    Environment = var.environment
  }
}

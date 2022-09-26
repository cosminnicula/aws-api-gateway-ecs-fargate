# ECR Docker
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = aws_subnet.private.*.id

  security_group_ids = [
    aws_security_group.ecs_task.id,
  ]

  tags = {
    Name        = "${var.deployment}-vpce-ecr_dkr"
    Environment = var.environment
  }
}

# ECR API
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = aws_subnet.private.*.id

  security_group_ids = [
    aws_security_group.ecs_task.id,
  ]

  tags = {
    Name        = "${var.deployment}-vpce-ecr_api"
    Environment = var.environment
  }
}

# S3
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_vpc.main.default_route_table_id]

  tags = {
    Name        = "${var.deployment}-vpce-s3"
    Environment = var.environment
  }
}

# CloudWatch
resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.ecs_task.id,
  ]

  tags = {
    Name        = "${var.environment}-vpce-cloudwatch"
    Environment = var.environment
  }
}

# Security group fro the ECS task
resource "aws_security_group" "ecs_task" {
  name   = "${var.deployment}-sg-ecs_task"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = var.microservice1_port
    to_port     = var.microservice1_port
    cidr_blocks = [var.vpc_main_cidr_block]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [var.vpc_main_cidr_block]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_main_cidr_block]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

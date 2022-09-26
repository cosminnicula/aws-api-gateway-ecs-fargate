# Network Load Balancer
resource "aws_lb" "main" {
  name               = "${var.deployment}-lb-main"
  internal           = true
  load_balancer_type = "network"
  subnets            = var.subnet_private_ids

  enable_deletion_protection = false

  tags = {
    Name        = "${var.deployment}-lb-main"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "main" {
  depends_on = [
    aws_lb.main
  ]

  name        = "${var.deployment}-lb-tg-main"
  port        = var.microservice1_port
  protocol    = "TCP"
  vpc_id      = var.vpc_main_id
  target_type = "ip"
  health_check {
    path = "/actuator/health"
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.id
  port              = var.microservice1_port
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.main.id
    type             = "forward"
  }
}

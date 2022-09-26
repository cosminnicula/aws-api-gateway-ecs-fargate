resource "aws_ecs_cluster" "main" {
  name = "${var.deployment}-ecs_cluster-main"

  tags = {
    Name        = "${var.deployment}-ecs_cluster-main"
    Environment = var.environment
  }
}

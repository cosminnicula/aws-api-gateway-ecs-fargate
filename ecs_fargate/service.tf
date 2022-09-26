resource "aws_ecs_service" "microservice1" {
  name            = "${var.deployment}-ecs_service-microservice1"
  cluster         = var.ecs_cluster_main_id
  task_definition = aws_ecs_task_definition.microservice1.family
  desired_count   = var.microservice1_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = ["${var.sg_ecs_task_id}"]
    subnets         = var.subnet_private_ids
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = "${var.deployment}-container-microservice1"
    container_port   = var.microservice1_port
  }

  depends_on = [
    aws_ecs_task_definition.microservice1,
  ]
}

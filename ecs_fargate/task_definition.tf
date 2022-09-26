resource "aws_ecs_task_definition" "microservice1" {
  family                   = "${var.deployment}-ecs_task_definition-microservice1"
  execution_role_arn       = aws_iam_role.ecs.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.microservice1_cpu_allocation
  memory                   = var.microservice1_memory_allocation
  container_definitions = jsonencode([
    {
      name : "${var.deployment}-container-microservice1",
      image : var.microservice1_docker_image,
      cpu : var.microservice1_cpu_allocation,
      memory : var.microservice1_memory_allocation,
      networkMode : "awsvpc",
      portMappings : [
        {
          containerPort : var.microservice1_port
          protocol : "tcp",
          hostPort : var.microservice1_port
        }
      ],
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          awslogs-group : local.cloudwatch_log_group_main,
          awslogs-region : var.region,
          awslogs-stream-prefix : "ecs"
        }
      }
    }
  ])
}

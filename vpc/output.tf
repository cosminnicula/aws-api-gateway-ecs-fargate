output "vpc_main_id" {
  value       = aws_vpc.main.id
  description = "Main VPC id"
}

output "subnet_private_ids" {
  value       = aws_subnet.private.*.id
  description = "Ids of the private subnets"
}

output "sg_ecs_task_id" {
  value       = aws_security_group.ecs_task.id
  description = "ECS task security group's id"
}

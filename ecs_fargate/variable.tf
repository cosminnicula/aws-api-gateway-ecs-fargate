variable "deployment" {
  type        = string
  description = "Deployment name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "microservice1_docker_image" {
  type        = string
  description = "Docker image for microservice1's task definition"
}

variable "microservice1_cpu_allocation" {
  type        = number
  description = "Fargate CPU allocation for microservice1"
}

variable "microservice1_memory_allocation" {
  type        = number
  description = "Fargate memory allocation for microservice1"
}

variable "microservice1_port" {
  type        = number
  description = "Microservice1's internal port"
}

variable "vpc_main_id" {
  type        = string
  description = "Main VPC id"
}

variable "subnet_private_ids" {
  type        = list(string)
  description = "Ids of the private subnets"
}

variable "ecs_cluster_main_id" {
  type        = string
  description = "Cluster id"
}

variable "microservice1_count" {
  type        = string
  description = "Number of task definition instances for microservice1"
}

variable "sg_ecs_task_id" {
  type        = string
  description = "ECS task security group's id"
}

locals {
  cloudwatch_log_group_main = "${var.deployment}-cloudwatch_log_group-${var.environment}"
}

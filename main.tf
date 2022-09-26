# VPC
module "vpc" {
  source = "./vpc"

  region = var.region

  # Deployment
  deployment  = var.deployment
  environment = var.environment

  # VPC
  vpc_main_cidr_block = var.vpc_main_cidr_block

  # Private subnet(s)
  subnet_private_count              = var.subnet_private_count
  subnet_private_cidr_blocks        = var.subnet_private_cidr_blocks
  subnet_private_availability_zones = var.subnet_private_availability_zones

  # Security group
  microservice1_port = var.microservice1_port
}

# ECS cluster
module "ecs_cluster" {
  source = "./ecs_cluster"

  # Deployment
  deployment  = var.deployment
  environment = var.environment
}

# ECS task definition, service and NLB 
module "ecs_fargate" {
  source = "./ecs_fargate"

  region = var.region

  # Deployment
  deployment  = var.deployment
  environment = var.environment

  # Task definition
  microservice1_docker_image      = var.microservice1_docker_image
  microservice1_cpu_allocation    = var.microservice1_cpu_allocation
  microservice1_memory_allocation = var.microservice1_memory_allocation
  microservice1_port              = var.microservice1_port
  vpc_main_id                     = module.vpc.vpc_main_id

  # NLB
  subnet_private_ids = module.vpc.subnet_private_ids

  # Service
  ecs_cluster_main_id = module.ecs_cluster.ecs_cluster_main_id
  microservice1_count = var.microservice1_count
  sg_ecs_task_id      = module.vpc.sg_ecs_task_id
}

# API Gateway and VPC link
module "api_gateway" {
  source = "./api_gateway"

  # Deployment
  deployment  = var.deployment
  environment = var.environment

  # VPC link
  lb_main_arn = module.ecs_fargate.lb_main_arn

  # API gateway
  lb_main_dns_name   = module.ecs_fargate.lb_main_dns_name
  microservice1_port = var.microservice1_port
}

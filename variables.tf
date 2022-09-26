variable "deployment" {
  description = "Deployment name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_main_cidr_block" {
  description = "CIDR block of the main VPC"
  type        = string
}

variable "subnet_private_count" {
  description = "Number of private subnets in the main VPC"
  type        = number
}

variable "subnet_private_cidr_blocks" {
  description = "CIDR blocks of the private subnet(s)"
  type        = list(string)
}

variable "subnet_private_availability_zones" {
  description = "AZs of the private subnet(s)"
  type        = list(string)
}

variable "microservice1_port" {
  description = "Microservice1's internal port"
  type        = number
}

variable "microservice1_count" {
  description = "Number of task definition instances for microservice1"
  type        = number
}

variable "microservice1_docker_image" {
  description = "Docker image for microservice1's task definition"
  type        = string
}

variable "microservice1_cpu_allocation" {
  description = "Fargate CPU allocation for microservice1"
  type        = number
}

variable "microservice1_memory_allocation" {
  description = "Fargate memory allocation for microservice1"
  type        = number
}

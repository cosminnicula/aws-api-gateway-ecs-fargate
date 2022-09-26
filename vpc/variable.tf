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

variable "vpc_main_cidr_block" {
  type        = string
  description = "CIDR block range of the main VPC"
}

variable "subnet_private_count" {
  type        = number
  description = "Number of private subnets in the main VPC"
}

variable "subnet_private_cidr_blocks" {
  type        = list(string)
  description = "CIDR block range(s) for the private subnets"
}

variable "subnet_private_availability_zones" {
  type        = list(string)
  description = "Availability zones for the private subnets"
}

variable "microservice1_port" {
  type        = string
  description = "Microservice1's internal port"
}

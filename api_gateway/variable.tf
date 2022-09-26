variable "deployment" {
  type        = string
  description = "Deployment name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "lb_main_arn" {
  type        = string
  description = "ARN of the private NLB"
}

variable "lb_main_dns_name" {
  type        = string
  description = "DNS name of the private NLB"
}

variable "microservice1_port" {
  type        = number
  description = "Microservice1's internal port"
}

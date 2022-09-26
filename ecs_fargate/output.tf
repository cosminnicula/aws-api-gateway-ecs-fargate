output "lb_main_arn" {
  value       = aws_lb.main.arn
  description = "Private NLB ARN"
}

output "lb_main_dns_name" {
  value       = aws_lb.main.dns_name
  description = "Private NLB DNS name"
}

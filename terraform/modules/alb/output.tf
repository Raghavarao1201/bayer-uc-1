output "alb_dns_name" {
  value       = aws_lb.alb.dns_name
  description = "DNS name of the Application Load Balancer"
}

output "alb_security_group_id" {
  value       = aws_security_group.alb_sg.id
  description = "ID of the ALB security group"
}

output "sales-person_target_group_arn" {
  value       = aws_lb_target_group.sales-person_target.arn
  description = "ARN of the Target Group for Patient Service"
}

output "alb_listener_arn" {
  value       = aws_lb_listener.http.arn
  description = "ARN of the ALB HTTP listener"
}
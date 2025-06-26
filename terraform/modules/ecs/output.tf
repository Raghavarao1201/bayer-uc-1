output "ecs_cluster_id" {
  value       = aws_ecs_cluster.ecs_cluster.id
  description = "ID of the ECS cluster"
}

output "ecs_service_id" {
  value       = aws_ecs_service.sales_agent_service.id
  description = "ID of the ECS service"
}

output "ecs_task_definition_arn" {
  value       = aws_ecs_task_definition.sales_agent_task.arn
  description = "ARN of the ECS task definition"
}

output "ecs_task_execution_role_arn" {
  value       = aws_iam_role.ecs_task_execution_role.arn
  description = "ARN of the ECS task execution role"
}

output "ecs_security_group_id" {
  value       = aws_security_group.ecs_sg.id
  description = "ID of the ECS security group"
}

output "cloudwatch_log_group_name" {
  value       = aws_cloudwatch_log_group.ecs_log_group.name
  description = "Name of the CloudWatch log group"
}
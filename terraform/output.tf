output "s3_audio_bucket_name" {
  description = "Audio bucket name"
  value       = module.s3.bucket_name
}

output "alb_dns_name" {
  value       = module.alb.alb_dns_name
  description = "DNS name of the Application Load Balancer"
}

output "ecs_service_id" {
  value       = module.ecs.ecs_service_id
  description = "ID of the ECS service"
}

output "ecs_cluster_id" {
  value       = module.ecs.ecs_cluster_id
  description = "ID of the ECS cluster"
}

output "cloudwatch_log_group_name" {
  value       = module.ecs.cloudwatch_log_group_name
  description = "Name of the CloudWatch log group"
}

output "lambda_function_name" {
  value       = module.lambda.lambda_function_name
  description = "Name of the Lambda function"
}

output "chime_capture_bucket" {
  value = module.chime.chime_capture_bucket
}

output "chime_capture_role_arn" {
  value = module.chime.chime_capture_role_arn
}

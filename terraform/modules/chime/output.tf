output "voice_connector_id" {
  value       = aws_chime_voice_connector.voice_connector.id
  description = "Voice Connector ID"
}

output "sma_lambda_function_name" {
  value       = aws_lambda_function.sma_handler.function_name
  description = "Lambda handler for Chime SIP media"
}

output "chime_capture_bucket" {
  value       = aws_s3_bucket.chime_sma_logs.bucket
  description = "S3 bucket used for Chime media capture logs"
}

output "chime_capture_role_arn" {
  value       = aws_iam_role.sma_lambda_role.arn
  description = "IAM role ARN for Chime Lambda"
}

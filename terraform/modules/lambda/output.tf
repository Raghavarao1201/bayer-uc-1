output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.store_summary.function_name
}
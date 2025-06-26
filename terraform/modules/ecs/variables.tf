variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "alb_security_group_id" {
  type        = string
  description = "ID of the ALB security group"
}

variable "alb_listener_arn" {
  type        = string
  description = "ARN of the ALB listener"
}

variable "patient_target_group_arn" {
  type        = string
  description = "ARN of the Target Group"
}

variable "container_image" {
  type        = string
  description = "ECR image URI"
}

variable "s3_audio_bucket_name" {
  type        = string
  description = "Name of the audio S3 bucket"
}
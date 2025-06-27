variable "environment" {
  type        = string
  description = "Deployment environment"
}

variable "ecs_endpoint" {
  type        = string
  description = "The ECS FastAPI public endpoint for processing audio"
}

variable "aws_region" {
  type        = string
  description = "AWS region for Chime setup"
}

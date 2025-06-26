variable "cidr_block" {
  type = string
}

variable "public_subnet_1_cidr_block" {
  type = string
}

variable "public_subnet_1_az" {
  type = string
}

variable "public_subnet_2_cidr_block" {
  type = string
}

variable "public_subnet_2_az" {
  type = string
}

variable "private_subnet_1_cidr_block" {
  type = string
}

variable "private_subnet_1_az" {
  type = string
}

variable "private_subnet_2_cidr_block" {
  type = string
}

variable "private_subnet_2_az" {
  type = string
}

variable "environment" {
  type        = string
  description = "Deployment environment"
  default     = "dev"
}

variable "container_image" {
  type        = string
  description = "ECR image URI for ECS container"
}
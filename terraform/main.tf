module "vpc" {
  source = "./modules/vpc"

  cidr_block                  = var.cidr_block
  public_subnet_1_cidr_block  = var.public_subnet_1_cidr_block
  public_subnet_2_cidr_block  = var.public_subnet_2_cidr_block
  private_subnet_1_cidr_block = var.private_subnet_1_cidr_block
  private_subnet_2_cidr_block = var.private_subnet_2_cidr_block

  public_subnet_1_az  = var.public_subnet_1_az
  public_subnet_2_az  = var.public_subnet_2_az
  private_subnet_1_az = var.private_subnet_1_az
  private_subnet_2_az = var.private_subnet_2_az
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "s3" {
  source      = "./modules/s3"
  environment = var.environment
}

module "ecs" {
  source                   = "./modules/ecs"
  container_image          = var.container_image
  s3_audio_bucket_name     = module.s3.bucket_name
  alb_security_group_id    = module.alb.alb_security_group_id
  alb_listener_arn         = module.alb.alb_listener_arn
  patient_target_group_arn = module.alb.sales-person_target_group_arn
  vpc_id                   = module.vpc.vpc_id
  private_subnet_ids       = module.vpc.private_subnet_ids
}

module "lambda" {
  source               = "./modules/lambda"
  s3_audio_bucket_name = module.s3.bucket_name
}

module "chime" {
  source       = "./modules/chime"
  environment  = var.environment
  aws_region   = var.aws_region
  ecs_endpoint = var.ecs_endpoint
}


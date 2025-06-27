cidr_block                  = "10.0.0.0/16"
public_subnet_1_cidr_block  = "10.0.1.0/24"
public_subnet_2_cidr_block  = "10.0.2.0/24"
private_subnet_1_cidr_block = "10.0.11.0/24"
private_subnet_2_cidr_block = "10.0.12.0/24"

public_subnet_1_az  = "us-east-1a"
public_subnet_2_az  = "us-east-1b"
private_subnet_1_az = "us-east-1a"
private_subnet_2_az = "us-east-1b"

environment     = "prod"
container_image = "994466158061.dkr.ecr.us-east-1.amazonaws.com/repo:sales-agent"


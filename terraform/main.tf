#####################################
# Network Module
#####################################

module "network" {

  source = "./modules/network"

  project_name = local.project_name

}

#####################################
# Security Module
#####################################

module "security" {

  source = "./modules/security"

  project_name = local.project_name

  vpc_id = module.network.vpc_id

}

#####################################
# Compute Module
#####################################

module "compute" {

  source = "./modules/compute"

  project_name = local.project_name

  public_subnet_id = module.network.public_subnet_1_id

  security_group_id = module.security.ec2_security_group_id

}

#####################################
# S3 Module
#####################################

module "s3" {

  source = "./modules/s3"

  project_name = local.project_name

}

#####################################
# ALB Module
#####################################

module "alb" {

  source = "./modules/alb"

  project_name = local.project_name

  vpc_id = module.network.vpc_id

  public_subnet_1_id = module.network.public_subnet_1_id

  public_subnet_2_id = module.network.public_subnet_2_id

  instance_id = module.compute.instance_id

}

#####################################
# RDS Module
#####################################

module "rds" {

  source = "./modules/rds"

  project_name = local.project_name

  private_subnet_1_id = module.network.private_subnet_1_id

  private_subnet_2_id = module.network.private_subnet_2_id

  vpc_id = module.network.vpc_id

  ec2_security_group_id = module.security.ec2_security_group_id

}
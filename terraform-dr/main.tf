#####################################
# Network Module
#####################################

module "network" {

  source = "./modules/network"

  project_name = local.project_name

  az_1 = "ap-south-2a"

  az_2 = "ap-south-2b"

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

#####################################
# SNS Module
#####################################

module "sns" {

  source = "./modules/sns"

  project_name = local.project_name

  email = "nikhilchamyal602@gmail.com"

}

#####################################
# Lambda Module
#####################################

module "lambda" {

  source = "./modules/lambda"

  project_name = local.project_name

  sns_topic_arn = module.sns.topic_arn

  instance_id = module.compute.instance_id

}

#####################################
# EBS Snapshot Module
#####################################

module "ebs_snapshot" {

  source = "./modules/ebs_snapshot"

  project_name = local.project_name

  instance_id = module.compute.instance_id

}

#####################################
# RDS Snapshot Module
#####################################

module "rds_snapshot" {

  source = "./modules/rds_snapshot"

  project_name = local.project_name

  db_identifier = module.rds.db_identifier

}

#####################################
# CloudWatch Module
#####################################

module "cloudwatch" {

  source = "./modules/cloudwatch"

  project_name = local.project_name

  instance_id = module.compute.instance_id

  sns_topic_arn = module.sns.topic_arn

}


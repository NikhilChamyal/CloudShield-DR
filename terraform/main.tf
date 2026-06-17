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
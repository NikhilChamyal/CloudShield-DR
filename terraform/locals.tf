locals {

  project_name = "CloudShield-DR"

  environment = "Development"

  common_tags = {
    Project     = local.project_name
    Environment = local.environment
    ManagedBy   = "Terraform"
    Owner       = "Nikhil Chamyal"
  }

}
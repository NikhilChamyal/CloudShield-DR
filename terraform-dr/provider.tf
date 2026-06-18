#####################################
# AWS Provider
#####################################

provider "aws" {

  region = var.aws_region

  default_tags {

    tags = {

      Project     = "CloudShield-DR"
      Environment = "Disaster-Recovery"
      Owner       = "Nikhil Chamyal"
      ManagedBy   = "Terraform"

    }

  }

}
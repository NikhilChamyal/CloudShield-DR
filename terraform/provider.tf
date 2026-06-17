provider "aws" {

  region = var.aws_region

  default_tags {

    tags = {

      Project     = "CloudShield-DR"
      Environment = "Development"
      Owner       = "Nikhil Chamyal"
      ManagedBy   = "Terraform"

    }

  }

}
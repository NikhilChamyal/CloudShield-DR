#####################################
# Primary Region (Mumbai)
#####################################

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

#####################################
# Disaster Recovery Region (Hyderabad)
#####################################

provider "aws" {

  alias = "dr"

  region = "ap-south-2"

  default_tags {

    tags = {

      Project     = "CloudShield-DR"
      Environment = "Disaster-Recovery"
      Owner       = "Nikhil Chamyal"
      ManagedBy   = "Terraform"

    }

  }

}
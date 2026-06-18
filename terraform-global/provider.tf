#####################################
# Primary Region Provider (Mumbai)
#####################################

provider "aws" {

  alias  = "primary"
  region = var.primary_region

  default_tags {
    tags = {
      Project     = "CloudShield-DR"
      Environment = "Global"
      Owner       = "Nikhil Chamyal"
      ManagedBy   = "Terraform"
    }
  }
}

#####################################
# Disaster Recovery Provider (Hyderabad)
#####################################

provider "aws" {

  alias  = "dr"
  region = var.dr_region

  default_tags {
    tags = {
      Project     = "CloudShield-DR"
      Environment = "Global"
      Owner       = "Nikhil Chamyal"
      ManagedBy   = "Terraform"
    }
  }
}
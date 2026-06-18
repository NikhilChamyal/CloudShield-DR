#####################################
# Primary Region
#####################################

variable "primary_region" {

  description = "Primary AWS Region"

  type = string

  default = "ap-south-1"

}

#####################################
# Disaster Recovery Region
#####################################

variable "dr_region" {

  description = "Disaster Recovery AWS Region"

  type = string

  default = "ap-south-2"

}

#####################################
# Primary Bucket
#####################################

variable "primary_bucket_name" {

  description = "Primary S3 Bucket"

  type = string

  default = "cloudshield-dr-5099a55b"

}

#####################################
# DR Bucket
#####################################

variable "dr_bucket_name" {

  description = "DR S3 Bucket"

  type = string

  default = "cloudshield-dr-dr-fa04e7a1"

}
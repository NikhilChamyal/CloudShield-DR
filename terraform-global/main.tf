#####################################
# Primary S3 Bucket
#####################################

data "aws_s3_bucket" "primary" {

  provider = aws.primary

  bucket = var.primary_bucket_name

}

#####################################
# DR S3 Bucket
#####################################

data "aws_s3_bucket" "dr" {

  provider = aws.dr

  bucket = var.dr_bucket_name

}

#####################################
# S3 Cross Region Replication
#####################################

module "s3_replication" {

  source = "./modules/s3_replication"

  project_name = "CloudShield-DR"

  primary_bucket_id = "cloudshield-dr-5099a55b"

  primary_bucket_arn = "arn:aws:s3:::cloudshield-dr-5099a55b"

  dr_bucket_arn = "arn:aws:s3:::cloudshield-dr-dr-fa04e7a1"

  replication_role_arn = aws_iam_role.replication.arn

}
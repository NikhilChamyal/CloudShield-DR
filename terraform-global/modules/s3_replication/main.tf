#####################################
# S3 Replication Configuration
#####################################

resource "aws_s3_bucket_replication_configuration" "replication" {

  bucket = var.primary_bucket_id

  role = var.replication_role_arn

  rule {

    id = "replicate-all"

    status = "Enabled"

    filter {}

    destination {

      bucket = var.dr_bucket_arn

      storage_class = "STANDARD"

    }

    delete_marker_replication {

      status = "Disabled"

    }

  }

}
#####################################
# Random Bucket Name
#####################################

resource "random_id" "bucket" {

  byte_length = 4

}

#####################################
# S3 Bucket
#####################################

resource "aws_s3_bucket" "backup" {

  bucket = lower("${var.project_name}-${random_id.bucket.hex}")

  tags = {

    Name = "${var.project_name}-Backup"

  }

}

#####################################
# Versioning
#####################################

resource "aws_s3_bucket_versioning" "backup" {

  bucket = aws_s3_bucket.backup.id

  versioning_configuration {

    status = "Enabled"

  }

}

#####################################
# Encryption
#####################################

resource "aws_s3_bucket_server_side_encryption_configuration" "backup" {

  bucket = aws_s3_bucket.backup.id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"

    }

  }

}

#####################################
# Public Access Block
#####################################

resource "aws_s3_bucket_public_access_block" "backup" {

  bucket = aws_s3_bucket.backup.id

  block_public_acls = true

  block_public_policy = true

  ignore_public_acls = true

  restrict_public_buckets = true

}

#####################################
# Lifecycle Rule
#####################################

resource "aws_s3_bucket_lifecycle_configuration" "backup" {

  bucket = aws_s3_bucket.backup.id

  rule {

    id = "cleanup"

    status = "Enabled"

    filter {}

    expiration {

      days = 365

    }

  }

}
#####################################
# IAM Role for S3 Replication
#####################################

resource "aws_iam_role" "replication" {

  name = "CloudShield-DR-S3-Replication"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "s3.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

}

#####################################
# IAM Policy
#####################################

resource "aws_iam_role_policy" "replication" {

  name = "CloudShield-DR-S3-Replication"

  role = aws_iam_role.replication.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Action = [

          "s3:GetReplicationConfiguration",

          "s3:ListBucket"

        ]

        Resource = [

          "arn:aws:s3:::cloudshield-dr-5099a55b"

        ]

      },

      {

        Effect = "Allow"

        Action = [

          "s3:GetObjectVersion",

          "s3:GetObjectVersionAcl",

          "s3:GetObjectVersionTagging"

        ]

        Resource = [

          "arn:aws:s3:::cloudshield-dr-5099a55b/*"

        ]

      },

      {

        Effect = "Allow"

        Action = [

          "s3:ReplicateObject",

          "s3:ReplicateDelete",

          "s3:ReplicateTags"

        ]

        Resource = [

          "arn:aws:s3:::cloudshield-dr-dr-fa04e7a1/*"

        ]

      }

    ]

  })

}
#####################################
# IAM Role
#####################################

resource "aws_iam_role" "snapshot_role" {

  name = "${var.project_name}-RDS-Snapshot-Lambda-Role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "lambda.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

}

#####################################
# CloudWatch Logs
#####################################

resource "aws_iam_role_policy_attachment" "basic_execution" {

  role = aws_iam_role.snapshot_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}

#####################################
# Snapshot Policy
#####################################

resource "aws_iam_role_policy" "snapshot_policy" {

  name = "${var.project_name}-RDS-Snapshot-Policy"

  role = aws_iam_role.snapshot_role.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Action = [

          "rds:CreateDBSnapshot",
          "rds:DeleteDBSnapshot",
          "rds:DescribeDBSnapshots",
          "rds:DescribeDBInstances",
          "rds:AddTagsToResource",
          "rds:ListTagsForResource"

        ]

        Resource = "*"

      }

    ]

  })

}
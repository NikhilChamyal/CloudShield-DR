#####################################
# Create Lambda ZIP
#####################################

data "archive_file" "snapshot_zip" {

  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "${path.module}/snapshot_lambda.zip"

}

#####################################
# Snapshot Lambda
#####################################

resource "aws_lambda_function" "snapshot" {

  function_name = "CloudShield-DR-DR-Snapshot"

  role = aws_iam_role.snapshot_role.arn

  runtime = "python3.12"

  handler = "lambda_function.lambda_handler"

  filename = data.archive_file.snapshot_zip.output_path

  source_code_hash = data.archive_file.snapshot_zip.output_base64sha256

  timeout = 300

  environment {

    variables = {

      PROJECT_NAME = var.project_name

    }

  }

}

#####################################
# EventBridge Schedule
#####################################

resource "aws_cloudwatch_event_rule" "daily_snapshot" {

  name = "${var.project_name}-Daily-Snapshot"

  description = "Daily EBS Snapshot"

  schedule_expression = "rate(1 day)"

}

#####################################
# EventBridge Target
#####################################

resource "aws_cloudwatch_event_target" "lambda" {

  rule = aws_cloudwatch_event_rule.daily_snapshot.name

  target_id = "SnapshotLambda"

  arn = aws_lambda_function.snapshot.arn

}

#####################################
# Allow EventBridge
#####################################

resource "aws_lambda_permission" "eventbridge" {

  statement_id = "AllowEventBridge"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.snapshot.function_name

  principal = "events.amazonaws.com"

  source_arn = aws_cloudwatch_event_rule.daily_snapshot.arn

}
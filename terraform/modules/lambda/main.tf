#####################################
# Create Lambda ZIP
#####################################

data "archive_file" "lambda_zip" {

  type = "zip"

  source_file = "${path.module}/lambda_function.py"

  output_path = "${path.module}/lambda_function.zip"

}

#####################################
# Lambda Function
#####################################

resource "aws_lambda_function" "auto_recovery" {

  function_name = "${var.project_name}-AutoRecovery"

  role = aws_iam_role.lambda_role.arn

  runtime = "python3.12"

  handler = "lambda_function.lambda_handler"

  filename = data.archive_file.lambda_zip.output_path

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  timeout = 30

  environment {

    variables = {

      INSTANCE_ID = var.instance_id

    }

  }

}

#####################################
# Allow SNS to Invoke Lambda
#####################################

resource "aws_lambda_permission" "allow_sns" {

  statement_id = "AllowExecutionFromSNS"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.auto_recovery.function_name

  principal = "sns.amazonaws.com"

  source_arn = var.sns_topic_arn

}

#####################################
# Subscribe Lambda to SNS
#####################################

resource "aws_sns_topic_subscription" "lambda" {

  topic_arn = var.sns_topic_arn

  protocol = "lambda"

  endpoint = aws_lambda_function.auto_recovery.arn

}
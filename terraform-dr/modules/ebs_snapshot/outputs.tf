output "snapshot_lambda_name" {

  description = "EBS Snapshot Lambda Function Name"

  value = aws_lambda_function.snapshot.function_name

}

output "eventbridge_rule_name" {

  description = "Daily Snapshot EventBridge Rule"

  value = aws_cloudwatch_event_rule.daily_snapshot.name

}
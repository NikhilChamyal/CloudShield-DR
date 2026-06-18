output "snapshot_lambda_name" {

  description = "RDS Snapshot Lambda"

  value = aws_lambda_function.snapshot.function_name

}

output "eventbridge_rule_name" {

  description = "RDS Snapshot Schedule"

  value = aws_cloudwatch_event_rule.daily_snapshot.name

}
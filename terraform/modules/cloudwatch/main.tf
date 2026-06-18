#####################################
# CPU Utilization Alarm
#####################################

resource "aws_cloudwatch_metric_alarm" "cpu_high" {

  alarm_name          = "cloudshield-dr-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70

  alarm_description = "CPU utilization exceeded 70%."

  alarm_actions = [
    var.sns_topic_arn
  ]

  dimensions = {
    InstanceId = var.instance_id
  }

}

#####################################
# EC2 Status Check Alarm
#####################################

resource "aws_cloudwatch_metric_alarm" "status_check" {

  alarm_name          = "cloudshield-dr-status-check"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Maximum"
  threshold           = 1

  alarm_description = "EC2 instance status check failed."

  alarm_actions = [
    var.sns_topic_arn
  ]

  dimensions = {
    InstanceId = var.instance_id
  }

}
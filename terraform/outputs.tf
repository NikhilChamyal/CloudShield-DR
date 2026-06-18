#####################################
# S3
#####################################

output "bucket_name" {

  value = module.s3.bucket_name

}

output "bucket_arn" {

  value = module.s3.bucket_arn

}

#####################################
# ALB
#####################################

output "alb_dns_name" {

  value = module.alb.alb_dns_name

}

#####################################
# RDS
#####################################

output "db_endpoint" {

  value = module.rds.db_endpoint

}

#####################################
# CloudWatch
#####################################

output "cpu_alarm_name" {

  value = module.cloudwatch.cpu_alarm_name

}
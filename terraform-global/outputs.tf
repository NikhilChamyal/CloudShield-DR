output "replication_role_arn" {

  value = aws_iam_role.replication.arn

}

output "replication_configuration_id" {

  value = module.s3_replication.replication_id

}
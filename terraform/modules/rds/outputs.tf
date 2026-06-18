output "db_endpoint" {
  value = aws_db_instance.mysql.endpoint
}

output "db_identifier" {
  value = aws_db_instance.mysql.identifier
}

output "rds_security_group_id" {
  value = aws_security_group.rds.id
}
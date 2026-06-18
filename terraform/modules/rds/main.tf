#####################################
# RDS Security Group
#####################################

resource "aws_security_group" "rds" {

  name        = "cloudshield-dr-rds-sg"
  description = "Security Group for RDS"
  vpc_id      = var.vpc_id

  ingress {

    description = "MySQL from EC2"

    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    security_groups = [
      var.ec2_security_group_id
    ]

  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  tags = {

    Name = "cloudshield-dr-rds-sg"

  }

}

#####################################
# DB Subnet Group
#####################################

resource "aws_db_subnet_group" "main" {

  name = "cloudshield-dr-db-subnet-group"

  subnet_ids = [
    var.private_subnet_1_id,
    var.private_subnet_2_id
  ]

  tags = {

    Name = "cloudshield-dr-db-subnet-group"

  }

}

#####################################
# MySQL Database
#####################################

resource "aws_db_instance" "mysql" {

  identifier = "cloudshield-dr-mysql"

  allocated_storage = 20

  max_allocated_storage = 20

  storage_type = "gp3"

  engine = "mysql"

  engine_version = "8.0"

  instance_class = "db.t3.micro"

  db_name = "cloudshield"

  username = "admin"

  password = "CloudShield123!"

  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  publicly_accessible = false

  multi_az = false

  storage_encrypted = true

  backup_retention_period = 1

  skip_final_snapshot = true

  deletion_protection = false

  auto_minor_version_upgrade = true

  apply_immediately = true

  tags = {

    Name        = "cloudshield-dr-mysql"
    Project     = var.project_name
    Backup      = "Enabled"
    Environment = "Development"
    Role        = "Database"
  }

}
#####################################
# Get Latest Amazon Linux 2023 AMI
#####################################

data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

#####################################
# IAM ROLE
#####################################

resource "aws_iam_role" "ec2_role" {

  name = "${var.project_name}-EC2-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

#####################################
# Attach SSM Policy
#####################################

resource "aws_iam_role_policy_attachment" "ssm" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

#####################################
# Instance Profile
#####################################

resource "aws_iam_instance_profile" "ec2_profile" {

  name = "${var.project_name}-EC2-Profile"

  role = aws_iam_role.ec2_role.name

}

#####################################
# EC2 INSTANCE
#####################################

resource "aws_instance" "web" {

  ami = data.aws_ami.amazon_linux.id

  instance_type = "t3.micro"

  subnet_id = var.public_subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  associate_public_ip_address = true

  user_data = file("${path.root}/userdata/install-nginx.sh")

  tags = {

    Name = "${var.project_name}-Web-Server"

    Project = var.project_name

    Role = "WebServer"

    Backup = "Enabled"

    Environment = "Development"

  }

}
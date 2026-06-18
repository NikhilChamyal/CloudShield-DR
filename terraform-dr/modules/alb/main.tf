#####################################
# ALB Security Group
#####################################

resource "aws_security_group" "alb" {

  name        = "${var.project_name}-ALB-SG"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  ingress {

    description = "HTTP"

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {

    Name = "${var.project_name}-ALB-SG"

  }

}

#####################################
# Load Balancer
#####################################

resource "aws_lb" "alb" {

  name = "${var.project_name}-ALB"

  internal = false

  load_balancer_type = "application"

  security_groups = [

    aws_security_group.alb.id

  ]

  subnets = [

    var.public_subnet_1_id,

    var.public_subnet_2_id

  ]

  tags = {

    Name = "${var.project_name}-ALB"

  }

}

#####################################
# Target Group
#####################################

resource "aws_lb_target_group" "tg" {

  name = "${var.project_name}-TG"

  port = 80

  protocol = "HTTP"

  vpc_id = var.vpc_id

  health_check {

    path = "/"

    protocol = "HTTP"

    matcher = "200"

  }

}

#####################################
# Attach EC2
#####################################

resource "aws_lb_target_group_attachment" "ec2" {

  target_group_arn = aws_lb_target_group.tg.arn

  target_id = var.instance_id

  port = 80

}

#####################################
# Listener
#####################################

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.alb.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.tg.arn

  }

}
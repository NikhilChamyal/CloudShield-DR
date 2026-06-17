#####################################
# VPC
#####################################

resource "aws_vpc" "main" {

  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-VPC"
  }
}

#####################################
# Public Subnet 1
#####################################

resource "aws_subnet" "public_1" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-Public-Subnet-1"
  }
}

#####################################
# Public Subnet 2
#####################################

resource "aws_subnet" "public_2" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-Public-Subnet-2"
  }
}

#####################################
# Private Subnet 1
#####################################

resource "aws_subnet" "private_1" {

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = "ap-south-1a"

  tags = {
    Name = "${var.project_name}-Private-Subnet-1"
  }
}

#####################################
# Private Subnet 2
#####################################

resource "aws_subnet" "private_2" {

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = "ap-south-1b"

  tags = {
    Name = "${var.project_name}-Private-Subnet-2"
  }
}

#####################################
# Internet Gateway
#####################################

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-IGW"
  }
}

#####################################
# Public Route Table
#####################################

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-Public-Route-Table"
  }
}

#####################################
# Public Route Table Associations
#####################################

resource "aws_route_table_association" "public_1" {

  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {

  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

#####################################
# OPTIONAL NAT GATEWAY
#####################################

resource "aws_eip" "nat" {

  count = var.enable_nat_gateway ? 1 : 0

  domain = "vpc"

  tags = {
    Name = "${var.project_name}-NAT-EIP"
  }
}

resource "aws_nat_gateway" "nat" {

  count = var.enable_nat_gateway ? 1 : 0

  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public_1.id

  depends_on = [
    aws_internet_gateway.igw
  ]

  tags = {
    Name = "${var.project_name}-NAT-Gateway"
  }
}

#####################################
# OPTIONAL PRIVATE ROUTE TABLE
#####################################

resource "aws_route_table" "private" {

  count = var.enable_nat_gateway ? 1 : 0

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[0].id
  }

  tags = {
    Name = "${var.project_name}-Private-Route-Table"
  }
}

resource "aws_route_table_association" "private_1" {

  count = var.enable_nat_gateway ? 1 : 0

  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private[0].id
}

resource "aws_route_table_association" "private_2" {

  count = var.enable_nat_gateway ? 1 : 0

  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private[0].id
}
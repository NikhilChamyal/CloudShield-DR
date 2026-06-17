#####################################
# VPC
#####################################

output "vpc_id" {
  value = aws_vpc.main.id
}

#####################################
# Public Subnets
#####################################

output "public_subnet_1_id" {
  value = aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_2.id
}

#####################################
# Private Subnets
#####################################

output "private_subnet_1_id" {
  value = aws_subnet.private_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_2.id
}

#####################################
# Internet Gateway
#####################################

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

#####################################
# NAT Gateway
#####################################

output "nat_gateway_id" {
  value = var.enable_nat_gateway ? aws_nat_gateway.nat[0].id : null
}
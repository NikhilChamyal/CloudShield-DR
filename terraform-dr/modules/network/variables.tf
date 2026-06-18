#####################################
# Project Name
#####################################

variable "project_name" {

  description = "Project Name"

  type = string

  default = "CloudShield-DR-DR"

}

#####################################
# VPC
#####################################

variable "vpc_cidr" {

  description = "CIDR block for the VPC"

  type = string

  default = "10.1.0.0/16"

}

#####################################
# Public Subnet 1
#####################################

variable "public_subnet_1_cidr" {

  description = "Public Subnet 1 CIDR"

  type = string

  default = "10.1.1.0/24"

}

#####################################
# Public Subnet 2
#####################################

variable "public_subnet_2_cidr" {

  description = "Public Subnet 2 CIDR"

  type = string

  default = "10.1.2.0/24"

}

#####################################
# Private Subnet 1
#####################################

variable "private_subnet_1_cidr" {

  description = "Private Subnet 1 CIDR"

  type = string

  default = "10.1.11.0/24"

}

#####################################
# Private Subnet 2
#####################################

variable "private_subnet_2_cidr" {

  description = "Private Subnet 2 CIDR"

  type = string

  default = "10.1.12.0/24"

}

#####################################
# NAT Gateway
#####################################

variable "enable_nat_gateway" {

  description = "Enable NAT Gateway"

  type = bool

  default = false

}

#####################################
# Availability Zones
#####################################

variable "az_1" {

  description = "First Availability Zone"

  type = string

  default = "ap-south-2a"

}

variable "az_2" {

  description = "Second Availability Zone"

  type = string

  default = "ap-south-2b"

}
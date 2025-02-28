# 1: terraform init
# 2: terraform validate
# 3: terraform apply
# 4: terraform destroy

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

# Create a VPC
resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.140.0.0/16"

  tags = {
    Name = "Demo VPC"
  }
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.demo_vpc.id
  cidr_block              = "10.140.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

# Create a private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.140.1.0/24"

  tags = {
    Name = "Private Subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

# Create a public route table
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "Public Route Table"
  }
}

# Create a route for the public route table to allow internet access
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rtb.id
}

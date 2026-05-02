# Day 3 Lab: Private Subnets & NAT Gateway
# (Extends Day 2)
provider "aws" {
  region = "us-east-1"
}

# Assume Day 2 resources exist, for this lab we build the private side
# In production, we'd use a single script or modules (Day 11)

# 1. Private Subnet
resource "aws_subnet" "private_1" {
  vpc_id            = "vpc-id-from-day2" # Update manually or use data source
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = { Name = "private-subnet-1" }
}

# 2. Elastic IP for NAT
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# 3. NAT Gateway (Sits in Public Subnet)
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = "subnet-id-of-public-1" # Sits in the public subnet

  tags = { Name = "dev-nat-gw" }
}

# 4. Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = "vpc-id-from-day2"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = { Name = "private-rt" }
}

# 5. Association
resource "aws_route_table_association" "private_1_assoc" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_rt.id
}


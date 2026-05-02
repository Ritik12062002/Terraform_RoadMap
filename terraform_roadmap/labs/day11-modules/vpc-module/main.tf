# VPC Module - main.tf
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = { Name = "${var.env}-vpc" }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, 1)
  tags = { Name = "${var.env}-public-1" }
}

output "vpc_id" {
  value = aws_vpc.this.id
}


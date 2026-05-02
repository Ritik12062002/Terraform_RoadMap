# Day 6 Lab: RDS Implementation
provider "aws" {
  region = "us-east-1"
}

resource "aws_db_subnet_group" "db_subnets" {
  name       = "main-db-subnet-group"
  subnet_ids = ["private-subnet-1", "private-subnet-2"] # Use your subnet IDs here

  tags = { Name = "My DB subnet group" }
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  db_name              = "production_db"
  engine               = "postgres"
  engine_version       = "15.3"
  instance_class       = "db.t3.micro"
  username             = "dbadmin"
  password             = "Password123!" # In real prod, use Secrets Manager!
  parameter_group_name = "default.postgres15"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = ["db-sg-id"]
}


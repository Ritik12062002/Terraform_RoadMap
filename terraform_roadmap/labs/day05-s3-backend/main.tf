# Day 5 Lab: S3 Backend & DynamoDB Locking
provider "aws" {
  region = "us-east-1"
}

# 1. S3 Bucket for State
resource "aws_s3_bucket" "terraform_state" {
  bucket = "ritik-terraform-state-unique-1234" # Change this!
  force_destroy = true 
}

resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 2. DynamoDB for Locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# NOTE: After running this once, you add this block to your code:
/*
terraform {
  backend "s3" {
    bucket         = "ritik-terraform-state-unique-1234"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
*/


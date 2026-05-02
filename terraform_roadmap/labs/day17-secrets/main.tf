# Day 17 Lab: AWS Secrets Manager
provider "aws" {
  region = "us-east-1"
}

resource "aws_secretsmanager_secret" "db_password" {
  name = "db-password-prod-1234"
}

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = "MySuperSecretPassword123!"
}

# Data source to fetch it elsewhere
data "aws_secretsmanager_secret_version" "creds" {
  secret_id = aws_secretsmanager_secret.db_password.id
}

output "db_pass" {
  value     = data.aws_secretsmanager_secret_version.creds.secret_string
  sensitive = true
}


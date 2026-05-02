# Day 15 Lab: IAM Security (Condition Keys)
provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_policy" "restricted_s3" {
  name        = "RestrictedS3Access"
  description = "Only allow access from specific IP"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:*"
        Effect   = "Deny"
        Resource = "*"
        Condition = {
          NotIpAddress = {
            "aws:SourceIp" = ["1.2.3.4/32"] # Replace with your office IP
          }
        }
      },
      {
        Action   = "s3:ListAllMyBuckets"
        Effect   = "Allow"
        Resource = "arn:aws:s3:::*"
      }
    ]
  })
}


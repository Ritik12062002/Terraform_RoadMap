provider "aws" {
  region = "us-east-1"
}

# 1. Create an IAM User
resource "aws_iam_user" "dev_user" {
  name = "ritik"
}

# 2. Define a Policy (Read Only Access to S3)
resource "aws_iam_policy" "s3_read_only" {
  name        = "S3ReadOnlyAccess-TF"
  description = "Allows read access to S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:Get*", "s3:List*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# 3. Attach Policy to User
resource "aws_iam_user_policy_attachment" "attach_s3" {
  user       = aws_iam_user.dev_user.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}

output "user_arn" {
  value = aws_iam_user.dev_user.arn
}


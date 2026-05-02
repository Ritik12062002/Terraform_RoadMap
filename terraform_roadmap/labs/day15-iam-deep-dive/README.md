# Day 15 Documentation: IAM Deep Dive & Condition Keys 👮‍♂️

## 1. What are we doing today?
Hardening your security. Instead of just "Allowing" access, we are adding **Conditions**. For example: "Allow ritik to see the bucket, but ONLY if he is logged in from our office IP address."

## 2. Line-by-Line Code Explanation (`main.tf`)

```hcl
resource "aws_iam_policy" "restricted_s3" {
...
  policy = jsonencode({
    Statement = [
      {
        Action   = "s3:*"
        Effect   = "Deny"
        Resource = "*"
        Condition = {
          NotIpAddress = { "aws:SourceIp" = ["1.2.3.4/32"] }
        }
      },
...
```
- **Line 8-15:** This is a **Deny Policy**. In AWS, a "Deny" always beats an "Allow".
- `Condition`: The "If" statement.
- `NotIpAddress`: "If the user is NOT at IP 1.2.3.4..."
- `Action: s3:*`: "...then Deny them access to everything in S3."

## 3. How to write your own code (Self-Explanation Guide)
1. **The "Deny by Default" Rule:** It's always safer to deny everything and allow selectively. 
2. **Use the Policy Simulator:** AWS has a free tool called "IAM Policy Simulator". Use it to test your code before you `apply`.
3. **Be Specific:** Don't use `Resource = "*"`. Try to use the specific ARN of the bucket you are protecting.
    


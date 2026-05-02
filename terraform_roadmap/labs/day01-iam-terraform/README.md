# 🛡️ Day 1: Identity & Access Management (IAM)
> **Topic:** Controlling the Keys to the Kingdom

---

## 🎯 Today's Mission
Today, we stop being "Root Users" and start being engineers. We will build a **Personalized Developer User** for **ritik** and give it restricted, professional access.

---

## 🔍 Line-by-Line Code Breakdown

### 🔗 Part 1: The AWS Plugin
```hcl
provider "aws" {
  region = "us-east-1"
}
```
- **Line 1-3:** Tells Terraform: *"Use the AWS toolkit and talk to the North Virginia region."*

### 👤 Part 2: Creating ritik
```hcl
resource "aws_iam_user" "dev_user" {
  name = "ritik"
}
```
- **Line 6-8:** Creates your digital ID. `dev_user` is your ID *inside the code*; `ritik` is your ID *inside AWS*.

### 📜 Part 3: The Permission Rule (S3 Read Only)
```hcl
resource "aws_iam_policy" "s3_read_only" {
  name        = "S3ReadOnlyAccess-TF"
  policy      = jsonencode({ ... })
}
```
- **The Brain:** This logic block says: *"This user is allowed to LOOK at files in S3, but cannot delete anything."*

### 🖇️ Part 4: The Connection
```hcl
resource "aws_iam_user_policy_attachment" "attach_s3" {
  user       = aws_iam_user.dev_user.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}
```
- **The Link:** Glueing the Permission to the User.

---

## 🧠 3. How to write like a Senior
1. **Speak the Code:** "I am creating an IAM User resource named ritik."
2. **Search the Docs:** Always keep the [AWS Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) open in a tab.
3. **Explain the Why:** In your comments, write why you chose `us-east-1` or why you restricted the policy.

---

### 🛠️ Hands-on Tasks:
- [ ] Run `terraform init` to download the provider.
- [ ] Run `terraform plan` and see the **+** (Plus) signs showing what will be added.
- [ ] Run `terraform apply` and check your AWS Console.

---
<p align="center">
  <b>Graduation progress: Day 1/20 ✅</b>
</p>

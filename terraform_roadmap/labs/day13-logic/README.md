# 🧠 Day 13: Count, For_Each & Dynamic Blocks
> **Topic:** User Logic & Iteration

---

## 🎯 1. The "Why" - Why are we doing this?
If you need 5 S3 buckets, you shouldn't write the `resource` block 5 times. That's "Wet" code (Write Everything Twice). We want "Dry" code (Don't Repeat Yourself). **Logic loops** allow you to write the code once and use a list to generate 5, 10, or 1,000 resources.

**Real World Use Case:** Generating IAM users for a whole department or creating Security Group rules for 20 different ports in one block.

---

## 🛠️ 2. Core Concepts & Definitions
- **Count:** A simple loop based on a number (0, 1, 2...).
- **For_Each:** A smarter loop based on a "Map" or a "Set" of strings. This is the preferred way!
- **Dynamic Blocks:** A way to loop INSIDE a resource (e.g., repeating `ingress` rules in a Security Group).
- **Each.key / Each.value:** How you access the current item in the loop.

---

## 🔍 3. Line-by-Line Code Explanation (`main.tf`)

```hcl
resource "aws_iam_user" "department" {
  for_each = toset(["alice", "bob", "ritik"])
  name     = each.value
}
```
- **Line 6:** `for_each = toset(...)` - Tells Terraform to iterate over this list of names.
- **Line 7:** `name = each.value` - On the first run, the name is "alice". On the second, "bob".

```hcl
resource "aws_security_group" "multi_rule" {
  dynamic "ingress" {
    for_each = [80, 443, 8080]
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```
- **Line 11:** `dynamic "ingress"` - This creates a loop for the firewall rules.
- **Line 13-17:** Terraform will generate THREE ingress rules (for ports 80, 443, and 8080) automatically.

---

## 🧠 4. Senior DevOps Insight
- **The Count Trap:** Never use `count` for resources that might be deleted in the middle of a list. If you have `[s3-1, s3-2, s3-3]` and you delete `s3-2`, Terraform will get confused and might try to rename `s3-3` to `s3-2`. Always use `for_each` for safety.
- **Complexity:** Don't go too deep with dynamic blocks. If your code is too "smart," it becomes hard for other engineers to read. Keep it simple.

---

### 🛠️ Hands-on Tasks:
- [ ] Run `terraform apply`.
- [ ] Check the AWS Console -> IAM. Did it create all 3 users?
- [ ] **Challenge:** Add another name to the `for_each` list and run `plan`. See how only ONE thing is added.

---
<p align="center">
  <b>Graduation progress: Day 13/20 ✅</b>
</p>

# 🧠 Day 13: Count, For_Each & Dynamic Blocks
> **Topic:** Power User Logic & Loops

---

## 🎯 Today's Mission
Stop writing repetitive code. If you need 10 users, don't write 10 resources. Today we master **Iterators**. We will use `for_each` and `dynamic` blocks to make our code clean, short, and powerful.

---

## 🔍 Line-by-Line Code Breakdown

### 🔄 Part 1: The for_each Loop
```hcl
resource "aws_iam_user" "users" {
  for_each = setproduct(["alice", "bob", "charlie"])
  name     = each.value
}
```
- **Efficiency:** This creates all three users in just 4 lines of code.

### ⚡ Part 2: The Dynamic Block
```hcl
dynamic "ingress" {
  for_each = [80, 443, 22]
  content {
    from_port = ingress.value
    to_port   = ingress.value
    protocol  = "tcp"
  }
}
```
- **Logic:** Automatically creates firewall rules for multiple ports in one go.

---

## 🧠 Senior DevOps Insight
- **Count vs. For_Each:** Always prefer `for_each` over `count`. If you remove an item from the middle of a `count` list, Terraform might delete and recreate every resource after it. `for_each` is index-independent and much safer.

---
<p align="center">
  <b>Graduation progress: Day 13/20 ✅</b>
</p>

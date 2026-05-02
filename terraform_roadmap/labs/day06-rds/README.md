# 💾 Day 6: RDS Managed Databases
> **Topic:** Powering Your Apps with Secure Data

---

## 🎯 Today's Mission
Provision a **Managed PostgreSQL Database**. We will ensure it is hidden in private subnets and only accessible by our web servers using **Security Group Referencing**.

---

## 🔍 Line-by-Line Code Breakdown

### 📍 Part 1: Subnet Placement
```hcl
resource "aws_db_subnet_group" "db_subnets" {
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}
```
- **Standard:** Databases should **NEVER** have a Public IP. We group private subnets here.

### 🏛️ Part 2: The DB Instance
```hcl
resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  instance_class    = "db.t3.micro"
  db_name              = "ritikdb"
  password             = var.db_password # Hiding secrets!
  skip_final_snapshot  = true
}
```
- **Cleanup:** `skip_final_snapshot = true` makes it easy to destroy the lab without waiting for a backup.

---

## 🧠 Senior DevOps Insight
- **Deletion Protection:** In any environment higher than 'Dev', always set `deletion_protection = true`. 
- **Multi-AZ:** For production, use `multi_az = true` to have a standby copy of your DB in another building.

---

### 🛠️ Hands-on Tasks:
- [ ] Deploy the RDS instance.
- [ ] Try to connect to it from your laptop (It should fail—that's good security!).
- [ ] Challenge: Create a Security Group rule that allows access only from your Day 4 EC2 SG.

---
<p align="center">
  <b>Graduation progress: Day 6/20 ✅</b>
</p>

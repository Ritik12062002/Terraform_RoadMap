# 🚀 Day 4: EC2 Compute & Security Firewalls
> **Topic:** Launching Your First Web Server

---

## 🎯 Today's Mission
Launch an **EC2 Instance** (Virtual Machine) and protect it with a **Security Group** (Firewall). We will also use "User Data" to automatically install a web server on the first boot.

---

## 🔍 Line-by-Line Code Breakdown

### 🛡️ Part 1: The Firewall (Security Group)
```hcl
resource "aws_security_group" "web_sg" {
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```
- **Rule:** This says "Allow anyone in the world to reach my server on Port 80 (HTTP)."

### 💻 Part 2: The Server (EC2)
```hcl
resource "aws_instance" "web_server" {
  ami           = "ami-0c101f26f1473a214"
  instance_type = "t2.micro"
  user_data     = <<-EOF ... EOF
}
```
- **AMI:** The operating system (Amazon Linux).
- **Type:** `t2.micro` is the "Free Tier" best friend.
- **User Data:** The magic script that installs Nginx/Apache automatically.

---

## 🧠 3. Senior DevOps Insight
- **IMDSv2:** Always ensure your EC2 instances use MetaData Service v2 to prevent credential theft.
- **Keyless Access:** In the real world, we use **AWS Systems Manager (SSM)** instead of SSH keys for better security auditing.

---

### 🛠️ Hands-on Tasks:
- [ ] Deploy the code and find your **Public IP**.
- [ ] Open the IP in your browser. Do you see the "Deployed via Terraform" message?
- [ ] **Challenge:** Try changing the HTML message in `user_data` and run `apply` again.

---
<p align="center">
  <b>Graduation progress: Day 4/20 ✅</b>
</p>

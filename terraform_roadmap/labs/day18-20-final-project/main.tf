# Day 18-20: 🏗️ FINAL PROJECT - 3-Tier Scalable Architecture

# --- 1. NETWORKING LAYER ---
module "vpc" {
  source = "../day11-modules/vpc-module" # Reusing your module!
  vpc_cidr = "10.0.0.0/16"
}

# --- 2. DATA LAYER (RDS) ---
resource "aws_db_instance" "prod_db" {
  allocated_storage = 20
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  # ... rest of RDS config from Day 6
}

# --- 3. APP LAYER (ALB + ASG) ---
resource "aws_lb" "prod_alb" {
  # ... ALB config from Day 7
}

resource "aws_autoscaling_group" "prod_asg" {
  # ... ASG config from Day 8
}

# --- 4. ACCESS CONTROL ---
# SG: ALB (Inbound 80) -> App (Inbound from ALB SG) -> DB (Inbound from App SG)

output "load_balancer_url" {
  value = aws_lb.prod_alb.dns_name
}


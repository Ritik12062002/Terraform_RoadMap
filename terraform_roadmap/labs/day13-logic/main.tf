# Day 13 Lab: Advanced Logic (for_each)
provider "aws" {
  region = "us-east-1"
}

variable "iam_users" {
  type    = list(string)
  default = ["alice", "bob", "charlie"]
}

resource "aws_iam_user" "users" {
  for_each = toset(var.iam_users)
  name     = each.value
}

variable "sg_ports" {
  type    = list(number)
  default = [80, 443, 8080]
}

resource "aws_security_group" "dynamic_sg" {
  name   = "dynamic-sg"
  vpc_id = "vpc-id"

  dynamic "ingress" {
    for_each = var.sg_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}


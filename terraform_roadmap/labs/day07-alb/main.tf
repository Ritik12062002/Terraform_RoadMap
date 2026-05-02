# Day 7 Lab: Application Load Balancer
provider "aws" {
  region = "us-east-1"
}

resource "aws_lb" "web_alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["alb-sg-id"]
  subnets            = ["public-subnet-1", "public-subnet-2"]

  enable_deletion_protection = false

  tags = { Name = "web-alb" }
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-id"

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}


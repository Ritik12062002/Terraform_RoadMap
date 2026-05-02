# Day 8 Lab: Auto Scaling Group
provider "aws" {
  region = "us-east-1"
}

resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-lt-"
  image_id      = "ami-0c101f26f1473a214"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["web-sg-id"]
  
  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
  )
}

resource "aws_autoscaling_group" "web_asg" {
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = ["private-subnet-1", "private-subnet-2"]

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  target_group_arns = ["web-tg-arn"]
}


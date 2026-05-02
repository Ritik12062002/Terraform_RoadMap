# Day 10 Lab: CloudWatch Monitoring
provider "aws" {
  region = "us-east-1"
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = "web-asg-name"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["sns-topic-arn"]
}

resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/aws/ec2/app-logs"
  retention_in_days = 7
}


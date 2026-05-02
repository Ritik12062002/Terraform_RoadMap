# Day 9 Lab: Route53 DNS
provider "aws" {
  region = "us-east-1"
}

resource "aws_route53_zone" "primary" {
  name = "example.com"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.example.com"
  type    = "A"

  alias {
    name                   = "alb-dns-name"
    zone_id                = "alb-zone-id"
    evaluate_target_health = true
  }
}


# Day 14 Lab: Best Practices (Structure)
provider "aws" {
  region = "us-east-1"
}

# Example of using Tags effectively
locals {
  common_tags = {
    Project   = "TerraformRoadmap"
    ManagedBy = "Terraform"
    Owner     = "ritik"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags       = local.common_tags
}


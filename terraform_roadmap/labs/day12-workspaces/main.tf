# Day 12 Lab: Workspaces
# Note: This lab is mostly practiced in the terminal
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "workspace_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${terraform.workspace}-vpc"
  }
}


# Day 11 Lab: Modules
# This example calls a local module

module "vpc" {
  source = "./vpc-module"

  vpc_cidr = "10.0.0.0/16"
  env      = "dev"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}


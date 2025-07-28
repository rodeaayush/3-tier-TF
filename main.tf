provider "aws" {
    region = "ap-south-1"
}
module "ec2"{
  source  = "./ec2"
  vpc_id = module.vpc.vpc_id
}
  module "vpc" {
    source = "./vpc"
  }

  module "rds" {
    source = "./rds"
     subnet_ids = module.vpc.private_subnet_ids
  }

provider "aws" {
    region = "ap-south-1"
}
module "ec2" {
  source  = "./ec2"

  }
  module "vpc" {
    source = "./vpc"
  }

  module "rds" {
    source = "./rds"
  }

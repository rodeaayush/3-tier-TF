provider "aws" {
    region = "ap-south-1"
}
module "ec2"{
  source  = "./ec2"
  vpc_id = module.vpc.vpc_id
  SG = module.ec2.common-sg
  private-tom = module.vpc.private_subnet_id
  private-db = module.vpc.private_db_subnet_id
  public-nginx = module.vpc.public_subnet_id
}
  module "vpc" {
    source = "./vpc"
  
  }

  module "rds" {
    source = "./rds"
     subnet_ID = module.vpc.private_subnet_ids
     SG = module.ec2.common-sg
  }

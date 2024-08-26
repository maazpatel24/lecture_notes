provider "aws" {
  region = "us-west-2"
}

module "ec2" {
  source         = "./modules/ec2"
  # ami            = var.ami
  instance_type  = var.instance_type
  instance_name  = var.instance_name
  key_pair       = var.key_pair
  public_subnet_id = module.vpc.ec2_instance_subnet_id
  security_group_id = module.vpc.vpc_ec2_sg_id
  iam_ec2_profile_name = module.s3.iam_ec2_profile_name
  project_name = var.project_name
}

module "s3" {
  source       = "./modules/s3"
  bucket_name  = var.bucket_name
  ec2_iam_role_arn = var.ec2_iam_role_arn
}

module "vpc" {
  source = "./modules/vpc"
}
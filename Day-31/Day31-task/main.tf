provider "aws" {
  region = "us-west-2"
  profile = terraform.workspace
}

module "ec2" {
    source = "./modules/ec2"
    ami = var.ami
    instance_type = var.instance_type
    instance_name = var.instance_name
    key_pair_name = var.key_pair_name
    ec2_iam_role_arn = module.IAM.iam_role_arn
    public_subnet_id = module.vpc.pub_subnet_id
    security_group_id = module.security_group.ec2_sg_id
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr_ip = var.vpc_cidr_ip
  pub_subnet_cidr_ip = var.pub_subnet_cidr_ip
  priv_subnet1_cidr_ip = var.priv_subnet1_cidr_ip
  priv_subnet2_cidr_ip = var.priv_subnet2_cidr_ip
}

module "security_group" {
  source = "./modules/security_group"
  my_vpc_id = module.vpc.my_vpc_id
}

module "IAM" {
  source = "./modules/IAM"
  s3_arn = module.s3.s3_arn
  rds_arn = module.rds.rds_arn
}

module "rds" {
  source = "./modules/rds"
  rds_instance_type = var.rds_instance_type
  rds_db_name = var.rds_db_name
  rds_password = var.rds_password
  rds_username = var.rds_username
  rds_subnet_group_name = module.vpc.rds_subnet_group_name
  rds_security_group_id = module.security_group.rds_sg_id
}

module "s3" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
  ec2_iam_role_arn = module.IAM.iam_role_arn
}
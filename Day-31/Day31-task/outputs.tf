# output of ec2 public ip
output "ec2_instance_ip" {
  value = module.ec2.instance_public_ip
}

# output of ec2 public ip
output "eip_instance" {
  value = module.ec2.eip_instance
}

# output of RDS endpoint
output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

# output of s3 bucket name
output "s3_bucket_arn" {
  value = module.s3.s3_arn
}
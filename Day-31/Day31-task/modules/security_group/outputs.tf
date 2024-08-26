# output of ec2 security group id
output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

# output of rds security group id
output "rds_sg_id" {
    value = aws_security_group.rds_sg.id  
}
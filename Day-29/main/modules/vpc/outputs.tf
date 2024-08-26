output "vpc_ec2_sg_id" {
  description = "security group id for ec2"
  value = aws_security_group.ec2_sg_ssh.id
}

output "ec2_instance_subnet_id" {
  description = "subnet id for ec2 instance"
  value = aws_subnet.Project_public_subnet.id
}
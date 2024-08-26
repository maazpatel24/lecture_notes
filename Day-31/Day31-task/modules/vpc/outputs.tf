# output of public subnet id
output "pub_subnet_id" {
  value = aws_subnet.public_subnet.id
}

# output of vpc id
output "my_vpc_id" {
  value = aws_vpc.my_vpc.id
}

# output of private subnet group for rds
output "rds_subnet_group_name" {
  value = aws_db_subnet_group.rds_subnet_group.name
}
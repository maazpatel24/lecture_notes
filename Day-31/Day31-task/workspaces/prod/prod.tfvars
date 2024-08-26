# ec2 Instance
ami = "ami-05134c8ef96964280"
instance_name = "maaz"
instance_type = "t2.micro"
key_pair_name = "terraform-maaz-key"

# s3 bucket
bucket_name = "day31-maaz"

# rds
rds_instance_type = "db.t3.micro"
rds_username = "admin"
rds_db_name = "database01"
rds_password = "password"

# vpc
vpc_cidr_ip = "10.2.0.0/16"
pub_subnet_cidr_ip = "10.2.1.0/24"
priv_subnet1_cidr_ip = "10.2.2.0/24"
priv_subnet2_cidr_ip = "10.2.3.0/24"
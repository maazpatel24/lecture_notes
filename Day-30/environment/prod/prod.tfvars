ami            = "ami-05134c8ef96964280"
instance_type  = "t2.micro"
instance_name  = "Webserver-chirag"
bucket_name    = "day30-chirag"
key_pair       = "terraform-chirag-key"
ec2_iam_role_arn = "arn:aws:iam::021891610828:role/EC2-S3-Role"
# project_name = "Shopmax-chirag"
vpc_cidr_ip = "10.1.0.0/16"
pub_subnet_cidr_ip = "10.1.1.0/24"
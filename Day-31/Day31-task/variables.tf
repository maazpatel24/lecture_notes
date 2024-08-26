# variable for ec2 instance ami
variable "ami" {
    type = string
}

# variable for ec2 instance type
variable "instance_type" {
    type = string
}

# variable for key-pair name
variable "key_pair_name" {
    type = string
}

# variable for ec2 instance name
variable "instance_name" {
    type = string
}

variable "vpc_cidr_ip" {
    description = "var for vpc cidr and ip"
    type = string
}

# variable for public subnet cidr ip
variable "pub_subnet_cidr_ip" {
    description = "var for public subnet cidr and ip"
    type = string
}

# variable for private subnet1 cidr ip
variable "priv_subnet1_cidr_ip" {
    description = "var for private subnet1 cidr and ip"
    type = string
}

# variable for private subnet2 cidr ip
variable "priv_subnet2_cidr_ip" {
    description = "var for private subnet2 cidr and ip"
    type = string
}

# variable for rds instance class name
variable "rds_instance_type" {
  type = string
  description = "instance type for rds instances"
}

# variable for rds username
variable "rds_username" {
    type = string
    description = "username for rds instances"
}

# variable for rds database name
variable "rds_db_name" {
    type = string
    description = "database name for rds instances"
}

# variable for rds database password
variable "rds_password" {
    type = string
    description = "password for rds instances"
}

# variable for s3 bucket name
variable "bucket_name" {
    type = string
}

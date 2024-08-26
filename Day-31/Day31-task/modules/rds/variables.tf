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

# variable for rds subnet group
variable "rds_subnet_group_name" {
    type = string
    description = "subnet group for rds instances"
}

# variable for rds security group id
variable "rds_security_group_id" {
    type = string
    description = "security group id for rds instances"
}
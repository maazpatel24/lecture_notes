# Variable for ami
variable "ami" {
  description = "variable for ami id"
  type = string
}

# variable for key pair
variable "key_pair_name" {
    description = "variable for key pair name"
    type = string
}

# variable for instance type
variable "instance_type" {
    description = "variable for instance type"
    type = string
}

# variable for iam role
# variable "ec2_role_name" {
#     description = "variable for iam role"
#     type = string
# }

# variable for subnet id
variable "public_subnet_id" {
    description = "variable for subnet id"
    type = string
}

# variable for sg id
variable "security_group_id" {
    description = "variable for sg id"
    type = string
}

# variable for instance name
variable "instance_name" {
    description = "variable for instance name"
    type = string
}

variable "ec2_iam_role_arn" {
    type        = string
    description = "The ARN of the IAM role to be used by the EC2 instance"
}
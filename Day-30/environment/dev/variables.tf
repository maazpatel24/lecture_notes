variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "key_pair" {
  description = "Name of your private key pair"
  type = string
}

# EC2 IAM Role ARN
variable "ec2_iam_role_arn" {
  description = "The ARN of the IAM role attached to the EC2 instance."
  type = string
}

# variable "project_name" {
#   type = string
# }

variable "vpc_cidr_ip" {
  description = "VPC cidr and the Ip address"
  type = string
}

variable "pub_subnet_cidr_ip" {
  description = "Public Subnet Ip address and Cidr"
  type = string
}
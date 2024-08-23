variable "aws_region" {
  description = "The AWS region to deploy resources in"
  default     = "us-west-2"
}

variable "ec2_ami_id" {
  default = "ami-0aff18ec83b712f05"

}
variable "ec2_instance_type" {
  default = "t2.micro"
}



# EC2 IAM Role ARN
variable "ec2_iam_role_arn" {
  description = "The ARN of the IAM role attached to the EC2 instance."
  default = "arn:aws:iam::326151034032:role/EC2-S3-Role"
  type = string
}

variable "db_instance_type" {
  default = "db.t3.micro"
}
variable "db_name" {
  default = "Database01"
}
variable "db_username" {
  default = "admin"
}
variable "db_password" {
  default = "password"
}
variable "bucket_name" {
  default = "shopmax-static-chirag"
}
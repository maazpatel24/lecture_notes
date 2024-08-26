# Configure AWS provider
provider "aws" {
  region = var.aws_region
  profile = "default"
}

variable "aws_region" {
  description = "variable for aws region"
  type = string
}

# DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_lock" {
  name         = var.dynamoDB_table_name
  hash_key      = "LockID"
  billing_mode  = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "DynamoDb-chirag"
  }
}

variable "dynamoDB_table_name" {
  description = "variable for dynamoDB table name"
  type = string
}

output "dynamoDB_table_name" {
  description = "Output of s3 bucket which is used for state files"
  value = aws_dynamodb_table.terraform_lock.name
}

# --------------------------------------------------------------------------------------------------------------

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_state_name  # Replace with a unique bucket name

  tags = {
    Name = var.bucket_state_name
  }
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

variable "bucket_state_name" {
  description = "S3 bucket name which is used for state files"
  type = string
}

output "s3_bucket_name" {
  description = "Output of s3 bucket which is used for state files"
  value = aws_s3_bucket.terraform_state.bucket
}

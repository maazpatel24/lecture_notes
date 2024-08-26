terraform {
  backend "s3" {
    bucket         = "shopmax-static-chirag"  # Same as the S3 bucket name
    key            = "terraform.tfstate"  # Replace with the path where you want to store the state file
    region         = "us-west-2"  # Same as the S3 bucket region
    dynamodb_table = "terraform-lock-table-chirag"  # Same as the DynamoDB table name
    encrypt        = true
  }
}

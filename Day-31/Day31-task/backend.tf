terraform {
  backend "s3" {
    bucket         = "terraform-state-chirag"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-stateLock-chirag"
  }
}
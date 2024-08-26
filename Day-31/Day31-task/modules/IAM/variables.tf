# variable for rds arn
variable "rds_arn" {
    type        = string
    description = "RDS instance ARN"
}

# variable for s3 bucket arn
variable "s3_arn" {
  type = string
  description = "S3 bucket ARN"
}
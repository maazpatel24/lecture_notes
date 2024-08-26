# output for s3 bucket arn
output "s3_arn" {
  value = aws_s3_bucket.app_bucket.arn
}
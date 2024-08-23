# Output important information
output "ec2_public_ip" {
  value = aws_instance.webserver.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.appdb.endpoint
}
output "s3_bucket_name" {
  value = aws_s3_bucket.app_bucket.bucket
}
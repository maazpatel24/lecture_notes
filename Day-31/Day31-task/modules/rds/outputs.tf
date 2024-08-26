# output of rds endpoint
output "rds_endpoint" {
  value = aws_db_instance.example.endpoint
}

# output of rds arn
output "rds_arn" {
  value = aws_db_instance.example.arn
}
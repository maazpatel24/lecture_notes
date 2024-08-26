# output of IAM role arn
output "iam_role_arn" {
  value = aws_iam_role.ec2_s3_rds_role.arn
}
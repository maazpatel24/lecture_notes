resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${terraform.workspace}-${var.bucket_name}"
  tags = {
    Name = "${terraform.workspace}-${var.bucket_name}"
  }
}

# associate iam role with ec2 instance
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${terraform.workspace}-EC2_instance_profile"
  role = basename(var.ec2_iam_role_arn)
  # tags = {
  #   Name = "${terraform.workspace}-instan-profile"
  # }
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.s3_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.ec2_iam_role_arn
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.s3_bucket.arn,
          "${aws_s3_bucket.s3_bucket.arn}/*"
        ]
      }
    ]
  })
}
# Create the IAM role
resource "aws_iam_role" "ec2_s3_rds_role" {
  name = "${terraform.workspace}-EC2-S3-RDS-Role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "${terraform.workspace}-iam-role-chirag"
  }
}

# Create IAM policy for S3 Full Access
resource "aws_iam_role_policy" "ec2_s3_policy" {
  name = "${terraform.workspace}-ec2_s3_policy"
  role = "${aws_iam_role.ec2_s3_rds_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "${var.s3_arn}"
    }
  ]
}
EOF
}

# Create the IAM policy for RDS access
resource "aws_iam_role_policy" "ec2_rds_policy" {
  name        = "${terraform.workspace}-ec2_rds_policy"
  role = "${aws_iam_role.ec2_s3_rds_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1724486869142",
      "Action": [
        "rds-db:connect"
      ],
      "Effect": "Allow",
      "Resource": "${var.rds_arn}"
    }
  ]
}
EOF
}

# # Attach the policies to the IAM role
# resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
#   role       = aws_iam_role.ec2_role.name
#   policy_arn = aws_iam_policy.s3_policy.arn
# }

# resource "aws_iam_role_policy_attachment" "rds_policy_attachment" {
#   role       = aws_iam_role.ec2_role.name
#   policy_arn = aws_iam_policy.rds_policy.arn
# }

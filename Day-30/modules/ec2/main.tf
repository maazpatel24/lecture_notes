# Create EC2 instance
resource "aws_instance" "webserver" {
  ami                         = var.ami_map
  instance_type               = var.instance_type
  iam_instance_profile        = var.iam_ec2_profile_name
  associate_public_ip_address = true
  subnet_id                   = var.public_subnet_id
  # availability_zone           = "us-west-2a"
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_pair
  tags = {
    Name = "${terraform.workspace}-${var.instance_name}"
    # Project = var.project_name
  }
}
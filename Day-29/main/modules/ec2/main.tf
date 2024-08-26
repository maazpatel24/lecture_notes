# Create EC2 instance
resource "aws_instance" "webserver" {
  ami                         = lookup(var.ami_map, "ami1", "ami-05134c8ef96964280")
  instance_type               = var.instance_type
  iam_instance_profile        = var.iam_ec2_profile_name
  associate_public_ip_address = true
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_pair
  tags = {
    Name = var.instance_name
    Project = var.project_name
  }
}

# Define a variable for multiple security group IDs
variable "security_group_ids" {
  type    = list(string)
  default = []
}

# Example using length to count the number of instances
output "instance_count" {
  value = length([aws_instance.webserver.id])
}
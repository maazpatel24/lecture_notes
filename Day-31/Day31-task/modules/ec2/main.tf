# Create EC2 instance
resource "aws_instance" "webserver" {
  ami                         = var.ami
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  # associate_public_ip_address = true
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_pair_name
  tags = {
    Name = "${terraform.workspace}-${var.instance_name}"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/einfochips/Downloads/Ansible/terraform-maaz-key.pem")
    host        = self.public_ip
 
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2"
    ]
  }
  provisioner "local-exec" {
    command = "echo 'Apache installation initiated on ${aws_instance.webserver.public_ip}'"
  }
 
}

# Create the Elastic IP
resource "aws_eip" "my_eip" {
  domain = "vpc"
  # instance = aws_instance.webserver.id
  tags = {
    Name = "eip-maaz-${terraform.workspace}"
  }
}

# # Associate the Elastic IP with the EC2 instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.webserver.id
  allocation_id = aws_eip.my_eip.id
}

# associate iam role with ec2 instance
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${terraform.workspace}-ec2_instance_profile"
  role = basename(var.ec2_iam_role_arn)
}
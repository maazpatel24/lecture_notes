output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.webserver.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.webserver.public_ip
}

output "eip_instance" {
  description = "Public IP address of the EC2 instance"
  value       = aws_eip.my_eip.instance
}
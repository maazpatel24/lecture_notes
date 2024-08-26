# Create VPC, subnets, and security groups
resource "aws_vpc" "ProjectVPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MyVPC-chirag"
  }
}
# Create a public subnet
resource "aws_subnet" "Project_public_subnet" {
  vpc_id                  = aws_vpc.ProjectVPC.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# Create an internet gateway
resource "aws_internet_gateway" "Project_igw" {
  vpc_id = aws_vpc.ProjectVPC.id
  tags = {
    Name = "MyIGW-chirag"
  }
}
# Create a route table for the public subnet
resource "aws_route_table" "Project_public_rt" {
  vpc_id = aws_vpc.ProjectVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Project_igw.id
  }
}
# Associate the route table with the public subnet
resource "aws_route_table_association" "Project_public_rt_assoc" {
  subnet_id      = aws_subnet.Project_public_subnet.id
  route_table_id = aws_route_table.Project_public_rt.id
}

# Create EC2 Security Group
resource "aws_security_group" "ec2_sg_ssh" {
  vpc_id = aws_vpc.ProjectVPC.id
  tags = {
    Name = "ec2-sg-chirag"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "cidr_blocks" {
  type    = list(string)
  default = []
}

# Output the combined CIDR blocks as a single string
output "cidr_blocks_string" {
  value = join(", ", var.cidr_blocks)
}
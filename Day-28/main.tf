# Configure AWS provider
provider "aws" {
  region = var.aws_region
}

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
# Create a private subnet
resource "aws_subnet" "Project_private_subnet1" {
  vpc_id     = aws_vpc.ProjectVPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2a"
}

# Create a private subnet with availability zone
resource "aws_subnet" "Project_private_subnet2" {
    vpc_id     = aws_vpc.ProjectVPC.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-west-2b"
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
# Create RDS Security Group
resource "aws_security_group" "ec2_rds_ssh" {
  vpc_id = aws_vpc.ProjectVPC.id
  tags = {
    Name = "rds-sg-chirag"
  }
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg_ssh.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 instance
resource "aws_instance" "webserver" {
  ami           = var.ec2_ami_id # Ubuntu 22.04 lts
  instance_type = var.ec2_instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.Project_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg_ssh.id]
  key_name                    = "ansible-new-chirag"
  tags = {
    Name = "WebServer-chirag"
    Project = "Shopmax-Static"
  }
  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    sudo apt install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF
}

# create subnet group
resource "aws_db_subnet_group" "rds_subnet_group" {
    name       = "rds_subnet_group"
    subnet_ids = [aws_subnet.Project_private_subnet1.id, aws_subnet.Project_private_subnet2.id]
    tags = {
        Name = "RDS Subnet Group"
    }
}

# Create RDS MySQL instance
resource "aws_db_instance" "appdb" {
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = var.db_instance_type
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  allocated_storage      = 20
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.ec2_rds_ssh.id]
  skip_final_snapshot = false
  tags = {
    Name = "RDS-Instance-chirag"
  }
}

# Create S3 bucket
resource "aws_s3_bucket" "app_bucket" {
  bucket = var.bucket_name
  tags = {
    Name = "shopmax-static-chirag"
  }
}

# associate iam role with ec2 instance
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = basename(var.ec2_iam_role_arn)
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.app_bucket.id

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
          aws_s3_bucket.app_bucket.arn,
          "${aws_s3_bucket.app_bucket.arn}/*"
        ]
      }
    ]
  })
}


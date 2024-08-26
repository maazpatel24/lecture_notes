# Create the VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_ip

  tags = {
    Name = "${terraform.workspace}-MyVPC-chirag"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${terraform.workspace}-MyIGW-chirag"
  }
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.pub_subnet_cidr_ip
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${terraform.workspace}-pub-sub-chirag"
  }
}

# Create a private subnet 1
resource "aws_subnet" "private_subnet1" {
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = var.priv_subnet1_cidr_ip
    availability_zone       = "us-west-2a" 
    map_public_ip_on_launch = false

    tags = {
        Name = "${terraform.workspace}-Pri-Sub1-chirag"
    }
}

# Create a private subnet 2
resource "aws_subnet" "private_subnet2" {
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = var.priv_subnet2_cidr_ip
    availability_zone       = "us-west-2b" 
    map_public_ip_on_launch = false

    tags = {
        Name = "${terraform.workspace}-Pri-Sub2-chirag"
    }
}

# Create a route table for the public subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "${terraform.workspace}-Pub-RT-chirag"
  }
}

# Create a route table for the private subnet
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.my_vpc.id
    
    tags = {
        Name = "${terraform.workspace}-Pri-RT-chirag"
    }
}

# create subnet group of private subnet1 and private subnet2
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${terraform.workspace}-rds_subnet_group"
  subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
  tags = {
    Name = "${terraform.workspace} RDS Subnet Group"
  }
}

# Associate the private subnet 1 with the private route table

resource "aws_route_table_association" "private_rt_assoc1" {
    subnet_id      = aws_subnet.private_subnet1.id    
    route_table_id = aws_route_table.private_rt.id
}

# Associate the private subnet 2 with the private route table

resource "aws_route_table_association" "private_rt_assoc2" {
    subnet_id      = aws_subnet.private_subnet2.id    
    route_table_id = aws_route_table.private_rt.id
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

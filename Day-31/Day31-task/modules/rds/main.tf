# create RDS 
resource "aws_db_instance" "example" {
  allocated_storage   = 20
  engine              = "mysql"
  engine_version      = "5.7"
  instance_class      = var.rds_instance_type
  db_name             = var.rds_db_name
  username            = var.rds_username
  password            = var.rds_password
  publicly_accessible = false
  skip_final_snapshot = true
  db_subnet_group_name   = var.rds_subnet_group_name
  vpc_security_group_ids = [var.rds_security_group_id]
  tags = {
    Name = "RDS-chirag-${terraform.workspace}"
  }
}


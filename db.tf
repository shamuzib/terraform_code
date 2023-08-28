#Create RDS DB Inatnce
resource "aws_db_instance" "prod-AWS-rds" {
  allocated_storage    = 1
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "12.5"
  instance_class       = "db.r4.large"
  name                 = "prod-aurora-db"
  username             = var.user_name
  password             = var.password   
  parameter_group_name = "default.postgres12"

  skip_final_snapshot = true

  vpc_security_group_ids = [aws_security_group.prod_alb_pub_sg.id]

  tags = {
    Name = "ExampleDB"
  }
}

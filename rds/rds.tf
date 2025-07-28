resource "aws_db_subnet_group" "db-subnet" {
  name = "db-subnet"
  subnet_ids = [aws_subnet.private-tom.id,aws_subnet.private-db.id]
}

resource "aws_db_instance" "rds" {
  allocated_storage = 20
  db_name = "database1"
  engine = "mariadb"
  engine_version = "10.11.6"
  username = data.aws_ssm_parameter.db_username.value
  password = data.aws_ssm_parameter.db_password.value
  
  instance_class = "db.t3.micro"
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.db-subnet.name

  vpc_security_group_ids = [aws_security_group.demo-sg.id]

  tags = {
    Name = "DB-Instance"
  }
}

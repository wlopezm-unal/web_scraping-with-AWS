resource "aws_db_parameter_group" "db_parameter_group" {
  name   = "rds-databaset-proyecto"
  family = "mariadb10.11"

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }
  tags = {
    Name = "rds-databaset-proyecto"
  }
}
resource "aws_db_instance" "rds-database" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mariadb"
  engine_version       = "10.11.6"
  instance_class       = "db.t3.micro"
  username             = "usuario"
  password             = "asdf123#"
  parameter_group_name = "rds-databaset-proyecto"
  vpc_security_group_ids = [aws_security_group.aws_sg.id]
  db_subnet_group_name = aws_db_subnet_group.rds_ec2_subnet_group.name
  publicly_accessible  = false
  skip_final_snapshot  = false

  tags = {
    Name = "rds-database"
  }
}

resource "aws_db_subnet_group" "rds_ec2_subnet_group" {
  name       = "rds_ec2_subnet_group"
  subnet_ids = [aws_subnet.Subnet_vpc_publico.id, aws_subnet.Subnet_vpc_publico_2.id, aws_subnet.Subnet_privado.id]

  tags = {
    Name = "rds_ec2_subnet_group"
  }
}

data "aws_instance" "existing_ec2_instance" {
  instance_id = aws_instance.ec2_proyecto.id #incorporarlo a una ec2 ya existente
}

resource "aws_security_group_rule" "allow_ec2_to_rds" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.aws_sg.id

   cidr_blocks = ["${aws_instance.ec2_proyecto.private_ip}/32"]

}

output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.rds-database.endpoint
}





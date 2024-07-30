resource "aws_security_group" "aws_sg" {
  name = "aws_sg"
  description = "aws_sg allows HTTP, HTTPS and SSH traffic"
  vpc_id = aws_vpc.vpc_proyecto_tic.id
  tags = {
    Name = "aws_sg"
  }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Acceso SSL"
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]#limitar la direccion ip
        description = "Acceso SSH"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Salida a internet"
    }


}


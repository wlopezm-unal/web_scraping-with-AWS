resource "aws_vpc" "vpc_proyecto_tic" {
  cidr_block = "10.0.0.0/16"
   enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc_proyecto_tic"
  }
}

resource "aws_subnet" "Subnet_vpc_publico" {
  vpc_id = aws_vpc.vpc_proyecto_tic.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet_vpc_publico"
  }
}

resource "aws_subnet" "Subnet_vpc_publico_2" {
  vpc_id     = aws_vpc.vpc_proyecto_tic.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet_vpc_publico_2"
  }
}



resource "aws_subnet" "Subnet_privado" {
  vpc_id = aws_vpc.vpc_proyecto_tic.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "gw_publico" {
  vpc_id = aws_vpc.vpc_proyecto_tic.id
  tags = {
    Name = "gw_publico"
  }
}

resource "aws_route_table" "rt_publico" {
  vpc_id = aws_vpc.vpc_proyecto_tic.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id= aws_internet_gateway.gw_publico.id   
  }
}

resource "aws_route_table" "rt_privado" {
  vpc_id = aws_vpc.vpc_proyecto_tic.id
  tags = {
    Name = "rt_privado"
  }
}

resource "aws_route_table_association" "publico_rt_subnet" {
  subnet_id = aws_subnet.Subnet_vpc_publico.id
  route_table_id = aws_route_table.rt_publico.id
  
}

resource "aws_route_table_association" "privado_rt_subnet" {
  subnet_id = aws_subnet.Subnet_privado.id
  route_table_id = aws_route_table.rt_privado.id
  
}

resource "aws_route_table_association" "publico_2_rt_subnet" {
  subnet_id = aws_subnet.Subnet_vpc_publico_2.id
  route_table_id = aws_route_table.rt_publico.id
  
} 
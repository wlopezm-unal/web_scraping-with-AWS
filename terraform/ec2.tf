resource "aws_instance" "ec2_proyecto" {
    ami = "ami-04b70fa74e45c3917"  // Ubuntu 20.04 LTS en us-east-1
    instance_type = "t2.micro"
    subnet_id = aws_subnet.Subnet_vpc_publico.id
    key_name = "key_proyecto"
    vpc_security_group_ids = [aws_security_group.aws_sg.id]
    tags = {
        Name = "ec2_proyecto"
    }    
}


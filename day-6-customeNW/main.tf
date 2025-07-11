provider "aws" {
    region = "us-east-1" 
}

resource "aws_vpc" "name" {
  cidr_block = "10.0.2.0/16"
  tags = {
    Name = "myvpc"
  }
}

resource "aws_subnet" "name" {
vpc_id = aws_vpc.name.id
cidr_block = "10.0.2.0/24"
availability_zone = "us-east-1a"
tags = {
    Name = "mysubnet"
}
}

resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
        Name = "myIg"
    } 
}

resource "aws_route_table" "name" {
 vpc_id =  aws_vpc.name.id
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
 }
}

resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.name.id
    route_table_id = aws_route_table.name.id
}

resource "aws_security_group" "name" "allow_tls" {
    name = "allow_tls"
    vpc_id = aws_vpc.name.id
    tags = {
        Name = "mySG"
    }
}

ingress {
    description = "TLS from VPC"
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_block = ["0.0.0.0/0"]
}
  ingress {
    description ="TLS from vpc"
    from_port = 22
    to_port = 22
    protocol = "TCP"
     cidr_block = ["0.0.0.0/0"]
  }

ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
}

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" #all protocols 
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
resource "aws_instance" "name" {
    ami = "ami-05ffe3c48a9991133"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.name.id
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
}

resource "aws_subnet" "name" {
vpc_id = aws_vpc.name.id
cidr_block = "10.0.3.0/24"
availability_zone = "us-east-1b"
tags = {
    Name = "myprivatesubnet"
}
}

resource "aws_nat_gateway" "name" {
    allocation_id = aws_eip.name.id
    subnet_id =  aws_subnet.name.id
    tags = {
        Name = "myNAT"
    }
     depends_on = [aws_internet_gateway.name]
}

resource "aws_nat_gateway" "name" {
  allocation_id = aws_eip.mane.subnet_id
  subnet_id = aws_subnet.name.id
  secondary_allocation_ids = [aws_eip.secondary.id]
  secondary_private_ip_address = ["10.0.3.0/24"] 
}

resource "aws_nat_gateway" "name" {
    connectivity_type = "private"
    subnet_id = aws_subnet.name.id
}
resource "aws_nat_gateway" "name" {
  connectivity_type = "private"
  subnet_id = aws_subnet.name.id
  secondary_private_ip_address_count = 7
}
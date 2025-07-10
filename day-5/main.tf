resource "aws_instance" "example" {
  ami           = "ami-05ffe3c48a9991133"
  instance_type = "t2.micro"
}
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
  
}
resource "aws_vpc" "name2" {
    cidr_block = "10.0.0.0/24"
  
}
resource "aws_vpc" "name3" {
    cidr_block ="10.0.1.0/24"
    
}

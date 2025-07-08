

provider  "aws" {
    region = "us-east-1"
}

resource  "aws_instance" "example"{
    ami     = var.ami_id
    instance_type = var.instance_type
    key_name   = var.key_name

    tags = {
        Name = var.tag_name
    }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "terraform_ec2" {
  ami           = "ami-05ffe3c48a9991133"
  instance_type = "t2.micro"
  key_name      = "WAR2"

  tags = {
    Name = "TERRAFORM"




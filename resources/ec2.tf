
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# data "aws_vpc" "default" {
#   default = true
# }

# data "aws_subnet" "default" {
#   vpc_id = data.aws_vpc.default.id

#   default_for_az = true
# }

# data "aws_security_group" "default" {
#   name   = "default"
#   vpc_id = data.aws_vpc.default.id
# }

resource "aws_key_pair" "my_key" {
  key_name   = "server_key"
  public_key = file("./server.pub")
}

resource "aws_instance" "Rohit_server" {
  ami           = "ami-022374b883d9d7931"
  instance_type = "t3.micro"

  key_name = aws_key_pair.my_key.key_name

  tags = {
    Name = "server_ec2"
  }
}

output "public_ip" {
  value = aws_instance.Rohit_server.public_ip
}

output "public_dns" {
  value = aws_instance.Rohit_server.public_dns
}

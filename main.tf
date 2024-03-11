terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


module "vpc" {
  source = "./networking"
}

resource "aws_security_group" "aws_sg_east_1" {
  vpc_id      = module.vpc.vpc_id
  name        = "aws_sg_east_1"
  description = "Egress and ingress rules"

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}




resource "aws_instance" "paulo-ec2" {
  availability_zone = "us-east-1a"
  ami               = var.ec2_ami
  instance_type     = var.instance_type
  subnet_id         = module.vpc.public_subnet_id
  key_name          = "kp"
  security_groups   = [aws_security_group.aws_sg_east_1.id]

  tags = {
    env = "dev"
  }

}


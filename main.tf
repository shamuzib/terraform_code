terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "my_new_ec2" {
  ami           = "ami-00785f4835c6acf64"
  instance_type = "t2.nano"
  tags = {
    env = prod
  }
}

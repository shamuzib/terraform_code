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
  count = 2
  tags = {
    env = prod
  }
}

resource "aws_s3_bucket" "my_Bucket" {
  bucket = "my-s3-bucket-070192"
}

resource "aws_eip" "my-public-ip" {
 vpc = true 
}

output "s3bucket" {
  value = aws_s3_bucket.my_bucket
}

output "pubip" {
 value = aws_eip.my-public-ip
}
